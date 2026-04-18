import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// FCM Service to manage push notifications
class FCMService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  FCMService();

  String? _fcmToken;
  StreamSubscription<String>? _tokenSubscription;

  // Callback when message is received
  Function(RemoteMessage message)? onMessageReceived;

  /// Initialize FCM service
  Future<void> initialize() async {
    // Request notification permission
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission for notifications');
    } else {
      debugPrint('User declined or has not accepted permission');
    }

    // Get FCM token with error handling (iOS needs APNS token first)
    try {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        // Wait for APNS token on iOS (max 10 seconds)
        String? apnsToken;
        for (int i = 0; i < 10; i++) {
          apnsToken = await _messaging.getAPNSToken();
          if (apnsToken != null) break;
          await Future.delayed(const Duration(seconds: 1));
        }

        if (apnsToken == null) {
          debugPrint('APNS token not available - push notifications may not work');
        }
      }

      _fcmToken = await _messaging.getToken();
      debugPrint('FCM Token: $_fcmToken');
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      _fcmToken = null;
    }

    // Listen for token refresh
    _tokenSubscription = _messaging.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      debugPrint('New FCM Token: $newToken');
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle when user taps notification (background/terminated)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // Check if app was opened from notification (terminated state)
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  /// Handle foreground message
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Received foreground message: ${message.messageId}');
    debugPrint('Data: ${message.data}');
    onMessageReceived?.call(message);
  }

  /// Handle background message
  void _handleBackgroundMessage(RemoteMessage message) {
    debugPrint('Received background message: ${message.messageId}');
    debugPrint('Data: ${message.data}');
    onMessageReceived?.call(message);
  }

  /// Get current FCM token
  String? get fcmToken => _fcmToken;

  /// Dispose resources
  void dispose() {
    _tokenSubscription?.cancel();
  }
}

/// Handler for background messages (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling background message: ${message.messageId}');
  debugPrint('Data: ${message.data}');
}

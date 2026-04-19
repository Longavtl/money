import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/l10n/app_localizations.dart';

class QRScannerPage extends ConsumerStatefulWidget {
  const QRScannerPage({super.key});

  @override
  ConsumerState<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends ConsumerState<QRScannerPage> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  String? _scannedData;
  Map<String, String>? _parsedData;
  String? _detectedType;
  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_scannedData != null || _isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final barcode = barcodes.first;
    final String? data = barcode.rawValue;

    if (data == null || data.isEmpty) return;

    setState(() {
      _scannedData = data;
      _parseScannedData(data);
    });

    HapticFeedback.mediumImpact();
    _showResultBottomSheet();
  }

  void _parseScannedData(String data) {
    if (data.startsWith('http://') || data.startsWith('https://')) {
      _detectedType = 'link';
    } else if (data.startsWith('WIFI:')) {
      _detectedType = 'wifi';
      _parseWifiData(data);
    } else if (data.startsWith('BEGIN:VCARD')) {
      _detectedType = 'contact';
      _parseContactData(data);
    } else {
      _detectedType = 'text';
    }
  }

  void _parseWifiData(String data) {
    _parsedData = {};
    final ssidMatch = RegExp(r'S:([^;]+)').firstMatch(data);
    final passwordMatch = RegExp(r'P:([^;]+)').firstMatch(data);
    final encryptionMatch = RegExp(r'T:([^;]+)').firstMatch(data);

    if (ssidMatch != null) _parsedData!['ssid'] = ssidMatch.group(1)!;
    if (passwordMatch != null) _parsedData!['password'] = passwordMatch.group(1)!;
    if (encryptionMatch != null) _parsedData!['encryption'] = encryptionMatch.group(1)!;
  }

  void _parseContactData(String data) {
    _parsedData = {};
    final nameMatch = RegExp(r'FN:([^\n]+)').firstMatch(data);
    final phoneMatch = RegExp(r'TEL:([^\n]+)').firstMatch(data);
    final emailMatch = RegExp(r'EMAIL:([^\n]+)').firstMatch(data);

    if (nameMatch != null) _parsedData!['name'] = nameMatch.group(1)!;
    if (phoneMatch != null) _parsedData!['phone'] = phoneMatch.group(1)!;
    if (emailMatch != null) _parsedData!['email'] = emailMatch.group(1)!;
  }

  void _showResultBottomSheet() {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildResultSheet(l10n),
    ).then((_) {
      setState(() {
        _scannedData = null;
        _parsedData = null;
        _detectedType = null;
      });
    });
  }

  Widget _buildResultSheet(AppLocalizations l10n) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type indicator
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: _getTypeColor().withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(_getTypeIcon(), color: _getTypeColor(), size: 24.w),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getTypeLabel(l10n),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                          ),
                        ),
                        Text(
                          _getTypeDescription(l10n),
                          style: TextStyle(fontSize: 12.sp, color: textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Content preview
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black12 : const Color(0xffF8F9FD),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: _buildContentPreview(textPrimary, textSecondary),
                ),
                SizedBox(height: 20.h),

                // Action buttons
                ..._buildActionButtons(l10n),
                SizedBox(height: 12.h),

                // Scan again button
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.scanAgain),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentPreview(Color textPrimary, Color textSecondary) {
    if (_detectedType == 'wifi' && _parsedData != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_parsedData!['ssid'] != null)
            _buildPreviewRow('Network', _parsedData!['ssid']!, textPrimary, textSecondary),
          if (_parsedData!['password'] != null)
            _buildPreviewRow('Password', '********', textPrimary, textSecondary),
          if (_parsedData!['encryption'] != null)
            _buildPreviewRow('Security', _parsedData!['encryption']!, textPrimary, textSecondary),
        ],
      );
    } else if (_detectedType == 'contact' && _parsedData != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_parsedData!['name'] != null)
            _buildPreviewRow('Name', _parsedData!['name']!, textPrimary, textSecondary),
          if (_parsedData!['phone'] != null)
            _buildPreviewRow('Phone', _parsedData!['phone']!, textPrimary, textSecondary),
          if (_parsedData!['email'] != null)
            _buildPreviewRow('Email', _parsedData!['email']!, textPrimary, textSecondary),
        ],
      );
    } else {
      return Text(
        _scannedData ?? '',
        style: TextStyle(fontSize: 14.sp, color: textPrimary),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      );
    }
  }

  Widget _buildPreviewRow(String label, String value, Color textPrimary, Color textSecondary) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              label,
              style: TextStyle(fontSize: 13.sp, color: textSecondary),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActionButtons(AppLocalizations l10n) {
    final buttons = <Widget>[];

    if (_detectedType == 'link') {
      buttons.add(
        _buildActionButton(
          icon: Icons.open_in_browser,
          label: l10n.openLink,
          color: AppColors.primary,
          onTap: _openLink,
        ),
      );
    }

    if (_detectedType == 'wifi') {
      buttons.add(
        _buildActionButton(
          icon: Icons.copy,
          label: l10n.copyPassword,
          color: AppColors.success,
          onTap: _copyWifiPassword,
        ),
      );
    }

    // Always show copy button
    buttons.add(
      _buildActionButton(
        icon: Icons.copy,
        label: l10n.copyData,
        color: AppColors.lightTextSecondary,
        onTap: _copyData,
        isOutlined: true,
      ),
    );

    return buttons;
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isOutlined = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _isProcessing ? null : onTap,
          icon: Icon(icon, size: 18.w),
          label: Text(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: isOutlined ? Colors.white : color,
            foregroundColor: isOutlined ? color : Colors.white,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: isOutlined ? BorderSide(color: color) : BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openLink() async {
    if (_scannedData == null) return;

    final uri = Uri.tryParse(_scannedData!);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _copyWifiPassword() {
    final password = _parsedData?['password'];
    if (password != null) {
      Clipboard.setData(ClipboardData(text: password));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.passwordCopied)),
      );
    }
  }

  void _copyData() {
    if (_scannedData != null) {
      Clipboard.setData(ClipboardData(text: _scannedData!));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.dataCopied)),
      );
    }
  }

  Future<void> _pickImageAndScan() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final result = await _controller.analyzeImage(pickedFile.path);

    if (result != null && result.barcodes.isNotEmpty) {
      _onDetect(result);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.noQRCodeFound)),
      );
    }
  }

  Color _getTypeColor() {
    switch (_detectedType) {
      case 'link':
        return AppColors.primary;
      case 'wifi':
        return AppColors.success;
      case 'contact':
        return const Color(0xff5856D6);
      default:
        return AppColors.lightTextSecondary;
    }
  }

  IconData _getTypeIcon() {
    switch (_detectedType) {
      case 'link':
        return Icons.link;
      case 'wifi':
        return Icons.wifi;
      case 'contact':
        return Icons.person;
      default:
        return Icons.text_fields;
    }
  }

  String _getTypeLabel(AppLocalizations l10n) {
    switch (_detectedType) {
      case 'link':
        return l10n.websiteLink;
      case 'wifi':
        return l10n.wifiNetworkLabel;
      case 'contact':
        return l10n.qrContact;
      default:
        return l10n.qrText;
    }
  }

  String _getTypeDescription(AppLocalizations l10n) {
    switch (_detectedType) {
      case 'link':
        return l10n.openInBrowser;
      case 'wifi':
        return l10n.wifiCredentials;
      case 'contact':
        return l10n.contactInformation;
      default:
        return l10n.plainTextContent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scanAreaSize = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),

          // Overlay
          CustomPaint(
            painter: _ScannerOverlayPainter(scanAreaSize: scanAreaSize),
            child: const SizedBox.expand(),
          ),

          // App bar
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  Row(
                    children: [
                      // Flash toggle
                      ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, state, child) {
                          return IconButton(
                            onPressed: () => _controller.toggleTorch(),
                            icon: Icon(
                              state.torchState == TorchState.on
                                  ? Icons.flash_on
                                  : Icons.flash_off,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      // Camera switch
                      IconButton(
                        onPressed: () => _controller.switchCamera(),
                        icon: const Icon(Icons.cameraswitch, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom instruction
          Positioned(
            bottom: 100.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    l10n.pointCameraAtQR,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
                SizedBox(height: 16.h),
                TextButton.icon(
                  onPressed: _pickImageAndScan,
                  icon: const Icon(Icons.photo_library, color: Colors.white),
                  label: Text(
                    l10n.scanFromGallery,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  final double scanAreaSize;

  _ScannerOverlayPainter({required this.scanAreaSize});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = Colors.black54;

    final scanAreaLeft = (size.width - scanAreaSize) / 2;
    final scanAreaTop = (size.height - scanAreaSize) / 2;
    final scanAreaRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(scanAreaLeft, scanAreaTop, scanAreaSize, scanAreaSize),
      const Radius.circular(20),
    );

    // Draw dark overlay with cutout
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()..addRRect(scanAreaRect),
      ),
      backgroundPaint,
    );

    // Draw corner indicators
    final cornerPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    const cornerLength = 30.0;

    // Top-left corner
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop + cornerLength),
      Offset(scanAreaLeft, scanAreaTop + 20),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft + cornerLength, scanAreaTop),
      Offset(scanAreaLeft + 20, scanAreaTop),
      cornerPaint,
    );

    // Top-right corner
    canvas.drawLine(
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop + cornerLength),
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop + 20),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft + scanAreaSize - cornerLength, scanAreaTop),
      Offset(scanAreaLeft + scanAreaSize - 20, scanAreaTop),
      cornerPaint,
    );

    // Bottom-left corner
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop + scanAreaSize - cornerLength),
      Offset(scanAreaLeft, scanAreaTop + scanAreaSize - 20),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft + cornerLength, scanAreaTop + scanAreaSize),
      Offset(scanAreaLeft + 20, scanAreaTop + scanAreaSize),
      cornerPaint,
    );

    // Bottom-right corner
    canvas.drawLine(
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop + scanAreaSize - cornerLength),
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop + scanAreaSize - 20),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft + scanAreaSize - cornerLength, scanAreaTop + scanAreaSize),
      Offset(scanAreaLeft + scanAreaSize - 20, scanAreaTop + scanAreaSize),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

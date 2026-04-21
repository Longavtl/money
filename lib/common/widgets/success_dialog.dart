import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:money/core/configs/theme/app_colors.dart';

/// Success dialog with Lottie animation
class SuccessDialog extends StatefulWidget {
  final String title;
  final String? message;
  final String? buttonText;
  final VoidCallback? onDismiss;
  final String lottieAsset;

  const SuccessDialog({
    super.key,
    required this.title,
    this.message,
    this.buttonText,
    this.onDismiss,
    this.lottieAsset = 'assets/lottie/success.json',
  });

  /// Show success dialog
  static Future<void> show(
    BuildContext context, {
    required String title,
    String? message,
    String? buttonText,
    VoidCallback? onDismiss,
    String lottieAsset = 'assets/lottie/success.json',
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SuccessDialog(
        title: title,
        message: message,
        buttonText: buttonText,
        onDismiss: onDismiss,
        lottieAsset: lottieAsset,
      ),
    );
  }

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Start animation and show content after a delay
    _controller.forward();

    // Show content after animation starts
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _showContent = true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkSurface : Colors.white;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 300.w,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.success.withValues(alpha: 0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lottie animation
            SizedBox(
              width: 150.w,
              height: 150.w,
              child: Lottie.asset(
                widget.lottieAsset,
                controller: _controller,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback if lottie file not found
                  return _buildFallbackIcon();
                },
              ),
            ),

            // Content with fade-in animation
            AnimatedOpacity(
              opacity: _showContent ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              child: AnimatedSlide(
                offset: _showContent ? Offset.zero : const Offset(0, 0.2),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
                child: Column(
                  children: [
                    SizedBox(height: 16.h),

                    // Title
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),

                    // Message
                    if (widget.message != null) ...[
                      SizedBox(height: 8.h),
                      Text(
                        widget.message!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],

                    SizedBox(height: 24.h),

                    // Button
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        widget.onDismiss?.call();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.success,
                              AppColors.success.withValues(alpha: 0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.success.withValues(alpha: 0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.checkmark_circle_fill,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              widget.buttonText ?? 'OK',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackIcon() {
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.success,
            AppColors.success.withValues(alpha: 0.7),
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.success.withValues(alpha: 0.4),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Icon(
        CupertinoIcons.checkmark_alt,
        size: 48.sp,
        color: Colors.white,
      ),
    );
  }
}

/// Premium success dialog
class PremiumSuccessDialog extends StatelessWidget {
  final VoidCallback? onDismiss;

  const PremiumSuccessDialog({super.key, this.onDismiss});

  static Future<void> show(BuildContext context, {VoidCallback? onDismiss}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PremiumSuccessDialog(onDismiss: onDismiss),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SuccessDialog(
      title: 'Welcome to Premium!',
      message: 'You now have access to all premium features. Thank you for your support!',
      buttonText: 'Continue',
      onDismiss: onDismiss,
      lottieAsset: 'assets/lottie/premium_success.json',
    );
  }
}

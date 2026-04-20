import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/l10n/app_localizations.dart';

class QRPreviewPage extends ConsumerWidget {
  final String data;
  final String title;
  final String type;

  const QRPreviewPage({
    super.key,
    required this.data,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    final bgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.qrCode,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: textPrimary),
            onPressed: () => _showMoreOptions(context, l10n, surfaceColor, textPrimary, borderColor),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  // QR Code Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // QR Code
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: QrImageView(
                            data: data,
                            version: QrVersions.auto,
                            size: 200.w,
                            gapless: true,
                            errorCorrectionLevel: QrErrorCorrectLevel.H,
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Type badge
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: _getTypeColor().withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(_getTypeIcon(), size: 16.w, color: _getTypeColor()),
                              SizedBox(width: 6.w),
                              Text(
                                _getTypeLabel(l10n),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: _getTypeColor(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Title
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: textPrimary,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),

                        // Data preview
                        Text(
                          _getPreviewText(l10n),
                          style: TextStyle(fontSize: 14.sp, color: AppColors.primary),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Action buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActionButton(
                        context,
                        icon: Icons.copy,
                        label: l10n.copy,
                        onTap: () => _copyData(context, l10n),
                      ),
                      SizedBox(width: 32.w),
                      _buildActionButton(
                        context,
                        icon: Icons.share,
                        label: l10n.share,
                        onTap: _shareQR,
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Privacy note
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, size: 20.w, color: textSecondary),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            l10n.qrPrivacyNote,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom button
          _buildBottomButton(context, l10n, surfaceColor),
        ],
      ),
    );
  }

  IconData _getTypeIcon() {
    switch (type) {
      case 'link':
        return Icons.link;
      case 'text':
        return Icons.text_fields;
      case 'wifi':
        return Icons.wifi;
      case 'contact':
        return Icons.person;
      default:
        return Icons.qr_code;
    }
  }

  Color _getTypeColor() {
    switch (type) {
      case 'link':
        return AppColors.primary;
      case 'text':
        return AppColors.success;
      case 'wifi':
        return AppColors.warning;
      case 'contact':
        return const Color(0xFFAF52DE);
      default:
        return AppColors.primary;
    }
  }

  String _getTypeLabel(AppLocalizations l10n) {
    switch (type) {
      case 'link':
        return l10n.qrLink;
      case 'text':
        return l10n.qrText;
      case 'wifi':
        return l10n.qrWifi;
      case 'contact':
        return l10n.qrContact;
      default:
        return l10n.qrCode;
    }
  }

  String _getPreviewText(AppLocalizations l10n) {
    if (type == 'wifi') {
      return l10n.wifiNetwork(title);
    } else if (type == 'contact') {
      return l10n.contactInfo(title);
    }
    return data.length > 50 ? '${data.substring(0, 50)}...' : data;
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(icon, size: 24.w, color: AppColors.primary),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context, AppLocalizations l10n, Color surfaceColor) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _saveToGallery(context, l10n),
            icon: Icon(Icons.save_alt, size: 20.w),
            label: Text(l10n.saveToGallery),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }

  void _showMoreOptions(
    BuildContext context,
    AppLocalizations l10n,
    Color surfaceColor,
    Color textPrimary,
    Color borderColor,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            ListTile(
              leading: Icon(Icons.save_alt, color: textPrimary),
              title: Text(l10n.saveToGallery, style: TextStyle(color: textPrimary)),
              onTap: () {
                Navigator.pop(ctx);
                _saveToGallery(context, l10n);
              },
            ),
            ListTile(
              leading: Icon(Icons.copy, color: textPrimary),
              title: Text(l10n.copyData, style: TextStyle(color: textPrimary)),
              onTap: () {
                Navigator.pop(ctx);
                _copyData(context, l10n);
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: textPrimary),
              title: Text(l10n.share, style: TextStyle(color: textPrimary)),
              onTap: () {
                Navigator.pop(ctx);
                _shareQR();
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  void _copyData(BuildContext context, AppLocalizations l10n) {
    Clipboard.setData(ClipboardData(text: data));
    Fluttertoast.showToast(msg: l10n.dataCopied);
  }

  Future<void> _saveToGallery(BuildContext context, AppLocalizations l10n) async {
    try {
      final qrPainter = QrPainter(
        data: data,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.H,
        gapless: true,
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: Color(0xFF000000),
        ),
        dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: Color(0xFF000000),
        ),
      );

      const size = 512.0;
      final pictureRecorder = ui.PictureRecorder();
      final canvas = Canvas(pictureRecorder);

      canvas.drawRect(
        const Rect.fromLTWH(0, 0, size, size),
        Paint()..color = Colors.white,
      );

      const padding = 32.0;
      canvas.translate(padding, padding);
      qrPainter.paint(canvas, const Size(size - padding * 2, size - padding * 2));

      final picture = pictureRecorder.endRecording();
      final image = await picture.toImage(size.toInt(), size.toInt());
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        Fluttertoast.showToast(msg: l10n.cannotCreateQRImage);
        return;
      }

      final bytes = byteData.buffer.asUint8List();
      final fileName = 'QR_${title.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}';

      final result = await SaverGallery.saveImage(
        bytes,
        fileName: fileName,
        androidRelativePath: 'Pictures/MoneyWave',
        skipIfExists: false,
      );

      if (result.isSuccess) {
        Fluttertoast.showToast(msg: l10n.qrSavedToGallerySuccess);
      } else {
        Fluttertoast.showToast(msg: l10n.cannotSaveQR);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: l10n.errorWithMessage(e.toString()));
    }
  }

  void _shareQR() {
    SharePlus.instance.share(ShareParams(text: data, title: title));
  }
}

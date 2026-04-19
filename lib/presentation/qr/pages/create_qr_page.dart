import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/routes/app_routes.dart';
import 'package:money/l10n/app_localizations.dart';

enum QRType { link, text, wifi, contact }

class CreateQRPage extends ConsumerStatefulWidget {
  const CreateQRPage({super.key});

  @override
  ConsumerState<CreateQRPage> createState() => _CreateQRPageState();
}

class _CreateQRPageState extends ConsumerState<CreateQRPage> {
  QRType _selectedType = QRType.link;

  // Controllers for Link
  final _urlController = TextEditingController();

  // Controllers for Text
  final _textController = TextEditingController();

  // Controllers for WiFi
  final _ssidController = TextEditingController();
  final _wifiPasswordController = TextEditingController();
  String _encryptionType = 'WPA2';

  // Controllers for Contact
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    _textController.dispose();
    _ssidController.dispose();
    _wifiPasswordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          l10n.createQRCode,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.selectQRType,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _buildTypeSelector(l10n, surfaceColor, borderColor, textSecondary),
                  SizedBox(height: 24.h),
                  _buildInputArea(l10n, surfaceColor, borderColor, textPrimary, textSecondary),
                ],
              ),
            ),
          ),
          _buildGenerateButton(l10n, surfaceColor),
        ],
      ),
    );
  }

  Widget _buildTypeSelector(
    AppLocalizations l10n,
    Color surfaceColor,
    Color borderColor,
    Color textSecondary,
  ) {
    final types = [
      {'type': QRType.link, 'icon': Icons.link, 'label': l10n.qrLink},
      {'type': QRType.text, 'icon': Icons.text_fields, 'label': l10n.qrText},
      {'type': QRType.wifi, 'icon': Icons.wifi, 'label': l10n.qrWifi},
      {'type': QRType.contact, 'icon': Icons.person, 'label': l10n.qrContact},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: types.map((item) {
        final type = item['type'] as QRType;
        final icon = item['icon'] as IconData;
        final label = item['label'] as String;
        final isSelected = _selectedType == type;

        return GestureDetector(
          onTap: () => setState(() => _selectedType = type),
          child: Column(
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : surfaceColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : borderColor,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 24.w,
                    color: isSelected ? Colors.white : AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppColors.primary : textSecondary,
                ),
              ),
              if (isSelected)
                Container(
                  margin: EdgeInsets.only(top: 6.h),
                  width: 32.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                )
              else
                SizedBox(height: 9.h),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInputArea(
    AppLocalizations l10n,
    Color surfaceColor,
    Color borderColor,
    Color textPrimary,
    Color textSecondary,
  ) {
    switch (_selectedType) {
      case QRType.link:
        return _buildLinkInput(l10n, surfaceColor, borderColor, textPrimary, textSecondary);
      case QRType.text:
        return _buildTextInput(l10n, surfaceColor, borderColor, textPrimary, textSecondary);
      case QRType.wifi:
        return _buildWifiInput(l10n, surfaceColor, borderColor, textPrimary, textSecondary);
      case QRType.contact:
        return _buildContactInput(l10n, surfaceColor, borderColor, textPrimary, textSecondary);
    }
  }

  Widget _buildLinkInput(
    AppLocalizations l10n,
    Color surfaceColor,
    Color borderColor,
    Color textPrimary,
    Color textSecondary,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.websiteAddress,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: _urlController,
          hintText: 'https://example.com',
          prefixIcon: const Icon(Icons.language, size: 20),
          keyboardType: TextInputType.url,
          surfaceColor: surfaceColor,
          borderColor: borderColor,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
        ),
        SizedBox(height: 16.h),
        _buildInfoCard(l10n.qrLinkInfo, textSecondary),
      ],
    );
  }

  Widget _buildTextInput(
    AppLocalizations l10n,
    Color surfaceColor,
    Color borderColor,
    Color textPrimary,
    Color textSecondary,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.textContent,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: _textController,
          hintText: l10n.enterContent,
          maxLines: 4,
          surfaceColor: surfaceColor,
          borderColor: borderColor,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
        ),
      ],
    );
  }

  Widget _buildWifiInput(
    AppLocalizations l10n,
    Color surfaceColor,
    Color borderColor,
    Color textPrimary,
    Color textSecondary,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.networkNameSSID,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: _ssidController,
          hintText: 'My_Network',
          prefixIcon: const Icon(Icons.wifi, size: 20),
          surfaceColor: surfaceColor,
          borderColor: borderColor,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
        ),
        SizedBox(height: 16.h),
        Text(
          l10n.wifiPasswordLabel,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: _wifiPasswordController,
          hintText: '********',
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_outline, size: 20),
          surfaceColor: surfaceColor,
          borderColor: borderColor,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
        ),
        SizedBox(height: 16.h),
        Text(
          l10n.encryptionType,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _encryptionType,
              isExpanded: true,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              dropdownColor: surfaceColor,
              borderRadius: BorderRadius.circular(12.r),
              items: ['WPA2', 'WPA', 'WEP', l10n.noEncryption].map((e) {
                return DropdownMenuItem(
                  value: e == l10n.noEncryption ? 'nopass' : e,
                  child: Text(
                    e,
                    style: TextStyle(color: textPrimary),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) setState(() => _encryptionType = value);
              },
            ),
          ),
        ),
        SizedBox(height: 16.h),
        _buildInfoCard(l10n.qrWifiInfo, textSecondary),
      ],
    );
  }

  Widget _buildContactInput(
    AppLocalizations l10n,
    Color surfaceColor,
    Color borderColor,
    Color textPrimary,
    Color textSecondary,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.contactName,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: _nameController,
          hintText: l10n.contactNameHint,
          prefixIcon: const Icon(Icons.person_outline, size: 20),
          surfaceColor: surfaceColor,
          borderColor: borderColor,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
        ),
        SizedBox(height: 16.h),
        Text(
          l10n.phoneNumber,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: _phoneController,
          hintText: '+84 123 456 789',
          keyboardType: TextInputType.phone,
          prefixIcon: const Icon(Icons.phone_outlined, size: 20),
          surfaceColor: surfaceColor,
          borderColor: borderColor,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
        ),
        SizedBox(height: 16.h),
        Text(
          'Email',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: _emailController,
          hintText: 'email@example.com',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email_outlined, size: 20),
          surfaceColor: surfaceColor,
          borderColor: borderColor,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required Color surfaceColor,
    required Color borderColor,
    required Color textPrimary,
    required Color textSecondary,
    Widget? prefixIcon,
    int maxLines = 1,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 16.sp, color: textPrimary),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 16.sp, color: textSecondary),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.all(12.w),
                  child: IconTheme(
                    data: IconThemeData(color: textSecondary),
                    child: prefixIcon,
                  ),
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String message, Color textSecondary) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: AppColors.primary, size: 20.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 13.sp,
                color: textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateButton(AppLocalizations l10n, Color surfaceColor) {
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
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _generateQRCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code_2, size: 22.w),
                    SizedBox(width: 8.w),
                    Text(
                      l10n.generateQRButton,
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              l10n.qrGeneratedOnDevice,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _generateQRCode() {
    final l10n = AppLocalizations.of(context)!;
    String data = '';
    String title = '';
    String type = '';

    switch (_selectedType) {
      case QRType.link:
        final url = _urlController.text.trim();
        if (url.isEmpty) {
          _showError(l10n.pleaseEnterWebsite);
          return;
        }
        data = url.startsWith('http') ? url : 'https://$url';
        title = data;
        type = 'link';
        break;
      case QRType.text:
        final text = _textController.text.trim();
        if (text.isEmpty) {
          _showError(l10n.pleaseEnterTextContent);
          return;
        }
        data = text;
        title = text.length > 30 ? '${text.substring(0, 30)}...' : text;
        type = 'text';
        break;
      case QRType.wifi:
        final ssid = _ssidController.text.trim();
        if (ssid.isEmpty) {
          _showError(l10n.pleaseEnterWifiName);
          return;
        }
        final password = _wifiPasswordController.text;
        final encryption = _encryptionType == 'nopass' ? 'nopass' : _encryptionType;
        data = 'WIFI:T:$encryption;S:$ssid;P:$password;;';
        title = ssid;
        type = 'wifi';
        break;
      case QRType.contact:
        final name = _nameController.text.trim();
        if (name.isEmpty) {
          _showError(l10n.pleaseEnterContactName);
          return;
        }
        final phone = _phoneController.text.trim();
        final email = _emailController.text.trim();
        data = 'BEGIN:VCARD\nVERSION:3.0\nFN:$name\nTEL:$phone\nEMAIL:$email\nEND:VCARD';
        title = name;
        type = 'contact';
        break;
    }

    context.push(
      AppRoutes.qrPreview,
      extra: {'data': data, 'title': title, 'type': type},
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.danger,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}

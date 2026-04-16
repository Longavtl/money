import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';

/// Saved items page - shows saved loans and savings
class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF1a1a2e),
                    const Color(0xFF16213e),
                    const Color(0xFF0f3460),
                  ]
                : [
                    const Color(0xFFe8f4f8),
                    const Color(0xFFd4e5f7),
                    const Color(0xFFc9dff7),
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Text(
                  'Đã lưu',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
              ),

              // Empty state
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.bookmark,
                        size: 64.sp,
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.3)
                            : AppColors.lightTextSecondary.withValues(alpha: 0.5),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Chưa có mục nào được lưu',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.6)
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Tính toán và lưu để xem lại sau',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.4)
                              : AppColors.lightTextSecondary.withValues(alpha: 0.7),
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
    );
  }
}

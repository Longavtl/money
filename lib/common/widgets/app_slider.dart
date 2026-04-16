import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money/core/configs/theme/app_colors.dart';

class AppSliderInput extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final Color? activeColor;
  final String Function(double) valueFormatter;
  final ValueChanged<double> onChanged;

  const AppSliderInput({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    this.activeColor,
    required this.valueFormatter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final color = activeColor ?? AppColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: textSecondary,
              ),
            ),
            Text(
              valueFormatter(value),
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color,
            inactiveTrackColor: color.withOpacity(0.2),
            thumbColor: color,
            overlayColor: color.withOpacity(0.1),
            trackHeight: 6.h,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

/// Segmented control that works with TabController (for pages with TabBarView)
class AppTabSegmentedControl extends StatelessWidget {
  final List<String> segments;
  final TabController tabController;

  const AppTabSegmentedControl({
    super.key,
    required this.segments,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkSurface : AppColors.lightBackground;
    final selectedBgColor = isDark ? AppColors.darkBackground : AppColors.lightSurface;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          color: selectedBgColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: textPrimary,
        unselectedLabelColor: textSecondary,
        labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.normal),
        padding: EdgeInsets.all(4.w),
        labelPadding: EdgeInsets.zero,
        tabs: segments.map((s) => Tab(text: s, height: 36.h)).toList(),
      ),
    );
  }
}

/// Segmented control with internal TabController for pages without their own
class AppSegmentedControl extends StatefulWidget {
  final List<String> segments;
  final int selectedIndex;
  final ValueChanged<int> onSegmentSelected;

  const AppSegmentedControl({
    super.key,
    required this.segments,
    required this.selectedIndex,
    required this.onSegmentSelected,
  });

  @override
  State<AppSegmentedControl> createState() => _AppSegmentedControlState();
}

class _AppSegmentedControlState extends State<AppSegmentedControl> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.segments.length,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );
  }

  @override
  void didUpdateWidget(AppSegmentedControl oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _tabController.animateTo(widget.selectedIndex);
    }
    if (oldWidget.segments.length != widget.segments.length) {
      _tabController.dispose();
      _tabController = TabController(
        length: widget.segments.length,
        vsync: this,
        initialIndex: widget.selectedIndex,
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkSurface : AppColors.lightBackground;
    final selectedBgColor = isDark ? AppColors.darkBackground : AppColors.lightSurface;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        onTap: widget.onSegmentSelected,
        indicator: BoxDecoration(
          color: selectedBgColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: textPrimary,
        unselectedLabelColor: textSecondary,
        labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.normal),
        padding: EdgeInsets.all(4.w),
        labelPadding: EdgeInsets.zero,
        tabs: widget.segments.map((s) => Tab(text: s, height: 36.h)).toList(),
      ),
    );
  }
}

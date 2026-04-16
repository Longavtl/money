import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/core/constants/glass_settings.dart';
import 'package:money_mate/core/utils/currency_formatter.dart';
import 'package:money_mate/presentation/simulation/simulation_provider.dart';

class SimulationPage extends ConsumerWidget {
  const SimulationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(simulationProvider);
    final notifier = ref.read(simulationProvider.notifier);

    return AdaptiveLiquidGlassLayer(
      settings: RecommendedGlassSettings.standard,
      quality: GlassQuality.standard,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Mô phỏng',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (state.hasScenarios)
                    GlassIconButton(
                      icon: const Icon(CupertinoIcons.trash),
                      onPressed: () => _showClearConfirm(context, notifier),
                    ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: state.hasScenarios
                  ? _buildContent(context, ref, state, notifier)
                  : _buildEmptyState(context, notifier),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, SimulationNotifier notifier) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.chart_bar_alt_fill,
              size: 64.sp,
              color: Colors.white.withValues(alpha: 0.3),
            ),
            SizedBox(height: 16.h),
            Text(
              'Chưa có kịch bản nào',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Thêm khoản vay hoặc tiết kiệm để mô phỏng\ntài chính theo thời gian',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _AddButton(
                  label: 'Thêm khoản vay',
                  icon: CupertinoIcons.building_2_fill,
                  color: AppColors.warning,
                  onTap: () => _showAddScenario(context, notifier, ScenarioType.loan),
                ),
                SizedBox(width: 12.w),
                _AddButton(
                  label: 'Thêm tiết kiệm',
                  icon: CupertinoIcons.money_dollar_circle_fill,
                  color: AppColors.success,
                  onTap: () => _showAddScenario(context, notifier, ScenarioType.savings),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    SimulationState state,
    SimulationNotifier notifier,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline slider
          _buildTimelineCard(context, state, notifier),
          SizedBox(height: 16.h),

          // Summary at current month
          _buildSummaryCard(context, state),
          SizedBox(height: 16.h),

          // Scenarios list
          _buildSectionHeader('Khoản vay', state.loans.length),
          SizedBox(height: 8.h),
          ...state.loans.map((s) => _buildScenarioCard(context, s, state, notifier)),

          if (state.savings.isNotEmpty) ...[
            SizedBox(height: 16.h),
            _buildSectionHeader('Tiết kiệm', state.savings.length),
            SizedBox(height: 8.h),
            ...state.savings.map((s) => _buildScenarioCard(context, s, state, notifier)),
          ],

          SizedBox(height: 16.h),

          // Add buttons
          Row(
            children: [
              Expanded(
                child: _AddScenarioButton(
                  label: 'Thêm khoản vay',
                  icon: CupertinoIcons.plus,
                  color: AppColors.warning,
                  onTap: () => _showAddScenario(context, notifier, ScenarioType.loan),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _AddScenarioButton(
                  label: 'Thêm tiết kiệm',
                  icon: CupertinoIcons.plus,
                  color: AppColors.success,
                  onTap: () => _showAddScenario(context, notifier, ScenarioType.savings),
                ),
              ),
            ],
          ),

          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(
    BuildContext context,
    SimulationState state,
    SimulationNotifier notifier,
  ) {
    final currentMonth = state.currentMonth;
    final netWorth = state.getNetWorthAtMonth(currentMonth);
    final isPositive = netWorth >= 0;

    return GlassCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dòng thời gian',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Tháng $currentMonth',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.info,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Net worth display
          Center(
            child: Column(
              children: [
                Text(
                  'Tài sản ròng',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white60,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  CurrencyFormatter.format(netWorth.abs()),
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: isPositive ? AppColors.success : AppColors.danger,
                  ),
                ),
                Text(
                  isPositive ? 'Dương' : 'Âm (nợ nhiều hơn)',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isPositive ? AppColors.success : AppColors.danger,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // Slider
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.info,
              inactiveTrackColor: Colors.white24,
              thumbColor: AppColors.info,
              overlayColor: AppColors.info.withValues(alpha: 0.2),
              trackHeight: 4.h,
            ),
            child: Slider(
              value: currentMonth.toDouble(),
              min: 0,
              max: state.viewMonths.toDouble(),
              divisions: state.viewMonths,
              onChanged: (v) => notifier.setCurrentMonth(v.toInt()),
            ),
          ),

          // Time labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hiện tại',
                style: TextStyle(fontSize: 11.sp, color: Colors.white60),
              ),
              Text(
                '${state.viewMonths ~/ 12} năm',
                style: TextStyle(fontSize: 11.sp, color: Colors.white60),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, SimulationState state) {
    final month = state.currentMonth;

    double totalLoanBalance = 0;
    double totalSavingsBalance = 0;

    for (final scenario in state.scenarios) {
      final balance = scenario.getBalanceAtMonth(month);
      if (scenario.type == ScenarioType.loan) {
        totalLoanBalance += balance;
      } else {
        totalSavingsBalance += balance;
      }
    }

    return GlassCard(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: _SummaryItem(
              label: 'Còn nợ',
              value: CurrencyFormatter.formatShort(totalLoanBalance),
              color: AppColors.danger,
              icon: CupertinoIcons.arrow_down_circle_fill,
            ),
          ),
          Container(
            width: 1,
            height: 50.h,
            color: Colors.white24,
          ),
          Expanded(
            child: _SummaryItem(
              label: 'Tiết kiệm',
              value: CurrencyFormatter.formatShort(totalSavingsBalance),
              color: AppColors.success,
              icon: CupertinoIcons.arrow_up_circle_fill,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScenarioCard(
    BuildContext context,
    Scenario scenario,
    SimulationState state,
    SimulationNotifier notifier,
  ) {
    final isLoan = scenario.type == ScenarioType.loan;
    final color = isLoan ? AppColors.warning : AppColors.success;
    final balanceAtMonth = scenario.getBalanceAtMonth(state.currentMonth);
    final progress = 1 - (balanceAtMonth / scenario.principal).clamp(0.0, 1.0);

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Dismissible(
        key: Key(scenario.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.w),
          decoration: BoxDecoration(
            color: AppColors.danger.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            CupertinoIcons.trash,
            color: AppColors.danger,
            size: 24.sp,
          ),
        ),
        onDismissed: (_) => notifier.removeScenario(scenario.id),
        child: GlassCard(
          padding: EdgeInsets.all(14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      isLoan
                          ? CupertinoIcons.building_2_fill
                          : CupertinoIcons.money_dollar_circle_fill,
                      color: color,
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scenario.name,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${CurrencyFormatter.formatShort(scenario.principal)} • ${scenario.annualRate}%/năm • ${scenario.termMonths} tháng',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: isLoan ? progress : (1 - progress),
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation(color),
                  minHeight: 6.h,
                ),
              ),
              SizedBox(height: 8.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isLoan ? 'Còn nợ' : 'Số dư',
                    style: TextStyle(fontSize: 12.sp, color: Colors.white60),
                  ),
                  Text(
                    CurrencyFormatter.formatShort(balanceAtMonth),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddScenario(
    BuildContext context,
    SimulationNotifier notifier,
    ScenarioType type,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _AddScenarioSheet(
        type: type,
        onAdd: (scenario) {
          notifier.addScenario(scenario);
          Navigator.pop(ctx);
        },
      ),
    );
  }

  void _showClearConfirm(BuildContext context, SimulationNotifier notifier) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a2e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'Xóa tất cả?',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        content: Text(
          'Tất cả kịch bản sẽ bị xóa.',
          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy', style: TextStyle(color: Colors.white60)),
          ),
          TextButton(
            onPressed: () {
              notifier.clear();
              Navigator.pop(ctx);
            },
            child: Text('Xóa', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24.sp),
        SizedBox(height: 6.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AddButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddScenarioButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AddScenarioButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddScenarioSheet extends StatefulWidget {
  final ScenarioType type;
  final Function(Scenario) onAdd;

  const _AddScenarioSheet({
    required this.type,
    required this.onAdd,
  });

  @override
  State<_AddScenarioSheet> createState() => _AddScenarioSheetState();
}

class _AddScenarioSheetState extends State<_AddScenarioSheet> {
  final _nameController = TextEditingController();
  double _principal = 100000000;
  double _rate = 10;
  int _termMonths = 12;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoan = widget.type == ScenarioType.loan;
    final color = isLoan ? AppColors.warning : AppColors.success;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a2e),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          Text(
            isLoan ? 'Thêm khoản vay' : 'Thêm tiết kiệm',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.h),

          // Name input
          TextField(
            controller: _nameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: isLoan ? 'Tên khoản vay (VD: Mua nhà)' : 'Tên (VD: Tiết kiệm hưu trí)',
              hintStyle: TextStyle(color: Colors.white38),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Principal slider
          _buildSlider(
            label: isLoan ? 'Số tiền vay' : 'Số tiền gửi',
            value: _principal,
            min: 1000000,
            max: 10000000000,
            divisions: 1000,
            color: color,
            formatter: (v) => CurrencyFormatter.formatShort(v),
            onChanged: (v) => setState(() => _principal = v),
          ),
          SizedBox(height: 12.h),

          // Rate slider
          _buildSlider(
            label: 'Lãi suất năm',
            value: _rate,
            min: 0.1,
            max: 50,
            divisions: 499,
            color: AppColors.info,
            formatter: (v) => '${v.toStringAsFixed(1)}%',
            onChanged: (v) => setState(() => _rate = v),
          ),
          SizedBox(height: 12.h),

          // Term slider
          _buildSlider(
            label: 'Kỳ hạn',
            value: _termMonths.toDouble(),
            min: 1,
            max: 360,
            divisions: 359,
            color: AppColors.primary,
            formatter: (v) => CurrencyFormatter.formatTerm(v.toInt()),
            onChanged: (v) => setState(() => _termMonths = v.toInt()),
          ),
          SizedBox(height: 24.h),

          // Add button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final name = _nameController.text.isNotEmpty
                    ? _nameController.text
                    : (isLoan ? 'Khoản vay' : 'Tiết kiệm');

                widget.onAdd(Scenario(
                  name: name,
                  type: widget.type,
                  principal: _principal,
                  annualRate: _rate,
                  termMonths: _termMonths,
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Thêm',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20.h),
        ],
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Color color,
    required String Function(double) formatter,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 13.sp, color: Colors.white60),
            ),
            Text(
              formatter(value),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color,
            inactiveTrackColor: Colors.white24,
            thumbColor: color,
            overlayColor: color.withValues(alpha: 0.2),
            trackHeight: 4.h,
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

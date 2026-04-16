import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/presentation/simulation/simulation_provider.dart';
import 'package:money/common/widgets/app_card.dart';

class SimulationPage extends ConsumerWidget {
  const SimulationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(simulationProvider);
    final notifier = ref.read(simulationProvider.notifier);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Simulation',
                      style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: textPrimary),
                    ),
                  ),
                  if (state.hasScenarios)
                    IconButton(
                      icon: Icon(CupertinoIcons.trash, color: textSecondary),
                      onPressed: () => _showClearConfirm(context, notifier),
                    ),
                ],
              ),
            ),
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.chart_bar_alt_fill, size: 64.sp, color: textSecondary.withOpacity(0.3)),
            SizedBox(height: 16.h),
            Text('No scenarios yet', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: textSecondary)),
            SizedBox(height: 8.h),
            Text('Add loans or savings to simulate\nyour finances over time', textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp, color: textSecondary.withOpacity(0.6))),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _AddButton(label: 'Add Loan', icon: CupertinoIcons.building_2_fill, color: AppColors.warning, onTap: () => _showAddScenario(context, notifier, ScenarioType.loan)),
                SizedBox(width: 12.w),
                _AddButton(label: 'Add Savings', icon: CupertinoIcons.money_dollar_circle_fill, color: AppColors.success, onTap: () => _showAddScenario(context, notifier, ScenarioType.savings)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, SimulationState state, SimulationNotifier notifier) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimelineCard(context, state, notifier),
          SizedBox(height: 16.h),
          _buildSummaryCard(context, state),
          SizedBox(height: 16.h),
          Text('Loans', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: textPrimary)),
          SizedBox(height: 8.h),
          ...state.loans.map((s) => _buildScenarioCard(context, s, state, notifier)),
          if (state.savings.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Text('Savings', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: textPrimary)),
            SizedBox(height: 8.h),
            ...state.savings.map((s) => _buildScenarioCard(context, s, state, notifier)),
          ],
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: _AddScenarioButton(label: 'Add Loan', color: AppColors.warning, onTap: () => _showAddScenario(context, notifier, ScenarioType.loan))),
              SizedBox(width: 12.w),
              Expanded(child: _AddScenarioButton(label: 'Add Savings', color: AppColors.success, onTap: () => _showAddScenario(context, notifier, ScenarioType.savings))),
            ],
          ),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(BuildContext context, SimulationState state, SimulationNotifier notifier) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final currentMonth = state.currentMonth;
    final netWorth = state.getNetWorthAtMonth(currentMonth);
    final isPositive = netWorth >= 0;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Timeline', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: textPrimary)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(color: AppColors.info.withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
                child: Text('Month $currentMonth', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.info)),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Center(
            child: Column(
              children: [
                Text('Net Worth', style: TextStyle(fontSize: 13.sp, color: textSecondary)),
                SizedBox(height: 4.h),
                Text(CurrencyFormatter.format(netWorth.abs()), style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: isPositive ? AppColors.success : AppColors.danger)),
                Text(isPositive ? 'Positive' : 'Negative (debt)', style: TextStyle(fontSize: 12.sp, color: isPositive ? AppColors.success : AppColors.danger)),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          SliderTheme(
            data: SliderThemeData(activeTrackColor: AppColors.info, inactiveTrackColor: AppColors.info.withOpacity(0.2), thumbColor: AppColors.info, trackHeight: 4.h),
            child: Slider(value: currentMonth.toDouble(), min: 0, max: state.viewMonths.toDouble(), divisions: state.viewMonths, onChanged: (v) => notifier.setCurrentMonth(v.toInt())),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Now', style: TextStyle(fontSize: 11.sp, color: textSecondary)),
            Text('${state.viewMonths ~/ 12} years', style: TextStyle(fontSize: 11.sp, color: textSecondary)),
          ]),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, SimulationState state) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    double totalLoanBalance = 0;
    double totalSavingsBalance = 0;
    for (final scenario in state.scenarios) {
      final balance = scenario.getBalanceAtMonth(state.currentMonth);
      if (scenario.type == ScenarioType.loan) totalLoanBalance += balance;
      else totalSavingsBalance += balance;
    }

    return AppCard(
      child: Row(
        children: [
          Expanded(child: _SummaryItem(label: 'Debt', value: CurrencyFormatter.formatShort(totalLoanBalance), color: AppColors.danger, icon: CupertinoIcons.arrow_down_circle_fill)),
          Container(width: 1, height: 50.h, color: borderColor),
          Expanded(child: _SummaryItem(label: 'Savings', value: CurrencyFormatter.formatShort(totalSavingsBalance), color: AppColors.success, icon: CupertinoIcons.arrow_up_circle_fill)),
        ],
      ),
    );
  }

  Widget _buildScenarioCard(BuildContext context, Scenario scenario, SimulationState state, SimulationNotifier notifier) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
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
          decoration: BoxDecoration(color: AppColors.danger.withOpacity(0.1), borderRadius: BorderRadius.circular(16.r)),
          child: Icon(CupertinoIcons.trash, color: AppColors.danger, size: 24.sp),
        ),
        onDismissed: (_) => notifier.removeScenario(scenario.id),
        child: AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8.r)),
                    child: Icon(isLoan ? CupertinoIcons.building_2_fill : CupertinoIcons.money_dollar_circle_fill, color: color, size: 18.sp),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(scenario.name, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: textPrimary)),
                        Text('${CurrencyFormatter.formatShort(scenario.principal)} • ${scenario.annualRate}%/yr • ${scenario.termMonths}mo', style: TextStyle(fontSize: 11.sp, color: textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(value: isLoan ? progress : (1 - progress), backgroundColor: color.withOpacity(0.2), valueColor: AlwaysStoppedAnimation(color), minHeight: 6.h),
              ),
              SizedBox(height: 8.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(isLoan ? 'Remaining' : 'Balance', style: TextStyle(fontSize: 12.sp, color: textSecondary)),
                Text(CurrencyFormatter.formatShort(balanceAtMonth), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: color)),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddScenario(BuildContext context, SimulationNotifier notifier, ScenarioType type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _AddScenarioSheet(type: type, onAdd: (scenario) { notifier.addScenario(scenario); Navigator.pop(ctx); }),
    );
  }

  void _showClearConfirm(BuildContext context, SimulationNotifier notifier) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: const Text('Clear All?'),
        content: const Text('All scenarios will be deleted.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(onPressed: () { notifier.clear(); Navigator.pop(ctx); }, child: Text('Delete', style: TextStyle(color: AppColors.danger))),
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

  const _SummaryItem({required this.label, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Column(
      children: [
        Icon(icon, color: color, size: 24.sp),
        SizedBox(height: 6.h),
        Text(value, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: textPrimary)),
        Text(label, style: TextStyle(fontSize: 12.sp, color: textSecondary)),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AddButton({required this.label, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20.sp),
            SizedBox(width: 8.w),
            Text(label, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: textPrimary)),
          ],
        ),
      ),
    );
  }
}

class _AddScenarioButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AddScenarioButton({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.plus, color: color, size: 18.sp),
            SizedBox(width: 8.w),
            Text(label, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: color)),
          ],
        ),
      ),
    );
  }
}

class _AddScenarioSheet extends StatefulWidget {
  final ScenarioType type;
  final Function(Scenario) onAdd;

  const _AddScenarioSheet({required this.type, required this.onAdd});

  @override
  State<_AddScenarioSheet> createState() => _AddScenarioSheetState();
}

class _AddScenarioSheetState extends State<_AddScenarioSheet> {
  final _nameController = TextEditingController();
  double _principal = 100000000;
  double _rate = 10;
  int _termMonths = 12;

  @override
  void dispose() { _nameController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final isLoan = widget.type == ScenarioType.loan;
    final color = isLoan ? AppColors.warning : AppColors.success;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.vertical(top: Radius.circular(24.r))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: borderColor, borderRadius: BorderRadius.circular(2.r)))),
          SizedBox(height: 20.h),
          Text(isLoan ? 'Add Loan' : 'Add Savings', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: textPrimary)),
          SizedBox(height: 20.h),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: isLoan ? 'Loan name (e.g., Home Loan)' : 'Name (e.g., Retirement)',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
          SizedBox(height: 16.h),
          _buildSlider(context, label: isLoan ? 'Amount' : 'Deposit', value: _principal, min: 1000000, max: 10000000000, divisions: 1000, color: color, formatter: (v) => CurrencyFormatter.formatShort(v), onChanged: (v) => setState(() => _principal = v)),
          SizedBox(height: 12.h),
          _buildSlider(context, label: 'Annual Rate', value: _rate, min: 0.1, max: 50, divisions: 499, color: AppColors.info, formatter: (v) => '${v.toStringAsFixed(1)}%', onChanged: (v) => setState(() => _rate = v)),
          SizedBox(height: 12.h),
          _buildSlider(context, label: 'Term', value: _termMonths.toDouble(), min: 1, max: 360, divisions: 359, color: AppColors.primary, formatter: (v) => CurrencyFormatter.formatTerm(v.toInt()), onChanged: (v) => setState(() => _termMonths = v.toInt())),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onAdd(Scenario(name: _nameController.text.isNotEmpty ? _nameController.text : (isLoan ? 'Loan' : 'Savings'), type: widget.type, principal: _principal, annualRate: _rate, termMonths: _termMonths));
              },
              style: ElevatedButton.styleFrom(backgroundColor: color, padding: EdgeInsets.symmetric(vertical: 14.h), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
              child: Text('Add', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20.h),
        ],
      ),
    );
  }

  Widget _buildSlider(BuildContext context, {required String label, required double value, required double min, required double max, required int divisions, required Color color, required String Function(double) formatter, required ValueChanged<double> onChanged}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: TextStyle(fontSize: 13.sp, color: textSecondary)),
          Text(formatter(value), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: textPrimary)),
        ]),
        SliderTheme(
          data: SliderThemeData(activeTrackColor: color, inactiveTrackColor: color.withOpacity(0.2), thumbColor: color, trackHeight: 4.h),
          child: Slider(value: value, min: min, max: max, divisions: divisions, onChanged: onChanged),
        ),
      ],
    );
  }
}

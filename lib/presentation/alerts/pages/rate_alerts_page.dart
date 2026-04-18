import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/domain/entities/rate_alert.dart';
import 'package:money/l10n/app_localizations.dart';
import 'package:money/presentation/alerts/alerts_provider.dart';
import 'package:money/common/widgets/app_card.dart';
import 'package:money/common/widgets/app_slider.dart';

class RateAlertsPage extends ConsumerWidget {
  const RateAlertsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(alertsProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.rateAlerts,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: textPrimary),
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.plus, color: AppColors.primary),
            onPressed: () => _showAddAlertSheet(context, ref, l10n),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Current Market Rates
                  _buildMarketRatesCard(context, ref, state.marketRates, l10n, textPrimary, textSecondary),
                  SizedBox(height: 20.h),

                  // Triggered Alerts
                  if (state.triggeredAlerts.isNotEmpty) ...[
                    _buildSectionHeader(l10n.triggeredAlerts, AppColors.success, state.triggeredAlerts.length, textPrimary),
                    SizedBox(height: 8.h),
                    ...state.triggeredAlerts.map((a) => _AlertCard(
                      alert: a,
                      marketRates: state.marketRates,
                      onToggle: () => ref.read(alertsProvider.notifier).toggleAlert(a.id),
                      onDelete: () => ref.read(alertsProvider.notifier).deleteAlert(a.id),
                      l10n: l10n,
                    )),
                    SizedBox(height: 16.h),
                  ],

                  // Active Alerts
                  if (state.activeAlerts.isNotEmpty) ...[
                    _buildSectionHeader(l10n.activeAlerts, AppColors.primary, state.activeAlerts.length, textPrimary),
                    SizedBox(height: 8.h),
                    ...state.activeAlerts.where((a) => !state.triggeredAlerts.contains(a)).map((a) => _AlertCard(
                      alert: a,
                      marketRates: state.marketRates,
                      onToggle: () => ref.read(alertsProvider.notifier).toggleAlert(a.id),
                      onDelete: () => ref.read(alertsProvider.notifier).deleteAlert(a.id),
                      l10n: l10n,
                    )),
                    SizedBox(height: 16.h),
                  ],

                  // All Alerts (inactive)
                  if (state.alerts.where((a) => !a.isActive).isNotEmpty) ...[
                    _buildSectionHeader(l10n.inactiveAlerts, textSecondary, state.alerts.where((a) => !a.isActive).length, textPrimary),
                    SizedBox(height: 8.h),
                    ...state.alerts.where((a) => !a.isActive).map((a) => _AlertCard(
                      alert: a,
                      marketRates: state.marketRates,
                      onToggle: () => ref.read(alertsProvider.notifier).toggleAlert(a.id),
                      onDelete: () => ref.read(alertsProvider.notifier).deleteAlert(a.id),
                      l10n: l10n,
                    )),
                  ],

                  if (state.alerts.isEmpty)
                    _buildEmptyState(context, ref, l10n, textSecondary),

                  SizedBox(height: 100.h),
                ],
              ),
            ),
    );
  }

  Widget _buildMarketRatesCard(
    BuildContext context,
    WidgetRef ref,
    List<MarketRate> rates,
    AppLocalizations l10n,
    Color textPrimary,
    Color textSecondary,
  ) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                l10n.currentMarketRates,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: textPrimary),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _showEditRatesSheet(context, ref, rates, l10n),
                icon: Icon(CupertinoIcons.pencil, size: 14.sp),
                label: Text(l10n.edit),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ...rates.map((rate) => _MarketRateRow(
            rate: rate,
            l10n: l10n,
            textPrimary: textPrimary,
            textSecondary: textSecondary,
          )),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color, int count, Color textPrimary) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: textPrimary),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            '$count',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: color),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref, AppLocalizations l10n, Color textSecondary) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.bell_slash, size: 64.sp, color: textSecondary.withValues(alpha: 0.3)),
            SizedBox(height: 16.h),
            Text(
              l10n.noAlertsYet,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: textSecondary),
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.addAlertsSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: textSecondary.withValues(alpha: 0.6)),
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: () => _showAddAlertSheet(context, ref, l10n),
              icon: const Icon(CupertinoIcons.plus),
              label: Text(l10n.addAlert),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddAlertSheet(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _AddAlertSheet(
        onAdd: (alert) {
          ref.read(alertsProvider.notifier).addAlert(alert);
          Navigator.pop(ctx);
        },
        l10n: l10n,
      ),
    );
  }

  void _showEditRatesSheet(BuildContext context, WidgetRef ref, List<MarketRate> rates, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _EditRatesSheet(
        rates: rates,
        onSave: (type, rate) {
          ref.read(alertsProvider.notifier).updateMarketRate(type, rate);
        },
        l10n: l10n,
      ),
    );
  }
}

class _MarketRateRow extends StatelessWidget {
  final MarketRate rate;
  final AppLocalizations l10n;
  final Color textPrimary;
  final Color textSecondary;

  const _MarketRateRow({
    required this.rate,
    required this.l10n,
    required this.textPrimary,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    final change = rate.previousRate != null ? rate.rate - rate.previousRate! : 0.0;
    final dateFormat = DateFormat('dd MMM');

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(_getLoanTypeIcon(rate.type), color: _getLoanTypeColor(rate.type), size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getLoanTypeLabel(rate.type, l10n),
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: textPrimary),
                ),
                Text(
                  '${l10n.updated}: ${dateFormat.format(rate.lastUpdated)}',
                  style: TextStyle(fontSize: 10.sp, color: textSecondary),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${rate.rate.toStringAsFixed(2)}%',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: textPrimary),
              ),
              if (change != 0)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      change > 0 ? CupertinoIcons.arrow_up : CupertinoIcons.arrow_down,
                      size: 10.sp,
                      color: change > 0 ? AppColors.danger : AppColors.success,
                    ),
                    Text(
                      '${change.abs().toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: change > 0 ? AppColors.danger : AppColors.success,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getLoanTypeIcon(RateLoanType type) {
    switch (type) {
      case RateLoanType.homeLoan:
        return CupertinoIcons.house_fill;
      case RateLoanType.personalLoan:
        return CupertinoIcons.person_fill;
      case RateLoanType.carLoan:
        return CupertinoIcons.car_fill;
      case RateLoanType.savings:
        return CupertinoIcons.bitcoin_circle_fill;
    }
  }

  Color _getLoanTypeColor(RateLoanType type) {
    switch (type) {
      case RateLoanType.homeLoan:
        return AppColors.primary;
      case RateLoanType.personalLoan:
        return AppColors.info;
      case RateLoanType.carLoan:
        return AppColors.warning;
      case RateLoanType.savings:
        return AppColors.success;
    }
  }

  String _getLoanTypeLabel(RateLoanType type, AppLocalizations l10n) {
    switch (type) {
      case RateLoanType.homeLoan:
        return l10n.homeLoan;
      case RateLoanType.personalLoan:
        return l10n.personalLoan;
      case RateLoanType.carLoan:
        return l10n.carLoan;
      case RateLoanType.savings:
        return l10n.savingsRate;
    }
  }
}

class _AlertCard extends StatelessWidget {
  final RateAlert alert;
  final List<MarketRate> marketRates;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final AppLocalizations l10n;

  const _AlertCard({
    required this.alert,
    required this.marketRates,
    required this.onToggle,
    required this.onDelete,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final marketRate = marketRates.firstWhere(
      (m) => m.type == alert.type,
      orElse: () => MarketRate(type: alert.type, rate: 0, lastUpdated: DateTime.now()),
    );

    final isTriggered = alert.isActive && (
      (alert.alertType == RateAlertType.below && marketRate.rate <= alert.targetRate) ||
      (alert.alertType == RateAlertType.above && marketRate.rate >= alert.targetRate)
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Dismissible(
        key: Key(alert.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.w),
          decoration: BoxDecoration(
            color: AppColors.danger.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(CupertinoIcons.trash, color: AppColors.danger, size: 24.sp),
        ),
        onDismissed: (_) => onDelete(),
        child: AppCard(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: (isTriggered ? AppColors.success : AppColors.primary).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  alert.alertType == RateAlertType.below
                      ? CupertinoIcons.arrow_down_circle_fill
                      : CupertinoIcons.arrow_up_circle_fill,
                  color: isTriggered ? AppColors.success : AppColors.primary,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alert.name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: alert.isActive ? textPrimary : textSecondary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${alert.alertType == RateAlertType.below ? l10n.when : l10n.when} ${alert.alertType == RateAlertType.below ? '≤' : '≥'} ${alert.targetRate}%',
                      style: TextStyle(fontSize: 12.sp, color: textSecondary),
                    ),
                    Text(
                      '${l10n.current}: ${marketRate.rate.toStringAsFixed(2)}%',
                      style: TextStyle(fontSize: 11.sp, color: textSecondary),
                    ),
                  ],
                ),
              ),
              if (isTriggered)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    l10n.triggered,
                    style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: AppColors.success),
                  ),
                ),
              SizedBox(width: 8.w),
              CupertinoSwitch(
                value: alert.isActive,
                activeColor: AppColors.primary,
                onChanged: (_) => onToggle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddAlertSheet extends StatefulWidget {
  final Function(RateAlert) onAdd;
  final AppLocalizations l10n;

  const _AddAlertSheet({required this.onAdd, required this.l10n});

  @override
  State<_AddAlertSheet> createState() => _AddAlertSheetState();
}

class _AddAlertSheetState extends State<_AddAlertSheet> {
  final _nameController = TextEditingController();
  RateLoanType _type = RateLoanType.homeLoan;
  RateAlertType _alertType = RateAlertType.below;
  double _targetRate = 8.0;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              widget.l10n.addAlert,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: textPrimary),
            ),
            SizedBox(height: 20.h),

            // Name
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: widget.l10n.alertNameHint,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 16.h),

            // Loan Type
            Text(widget.l10n.loanType, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: textPrimary)),
            SizedBox(height: 8.h),
            Row(
              children: RateLoanType.values.map((type) {
                final isSelected = _type == type;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: GestureDetector(
                      onTap: () => setState(() => _type = type),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                          border: Border.all(color: isSelected ? AppColors.primary : borderColor),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            _getLoanTypeShort(type),
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              color: isSelected ? AppColors.primary : textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.h),

            // Alert Type
            Text(widget.l10n.alertWhen, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: textPrimary)),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _alertType = RateAlertType.below),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: _alertType == RateAlertType.below ? AppColors.success.withValues(alpha: 0.1) : Colors.transparent,
                        border: Border.all(color: _alertType == RateAlertType.below ? AppColors.success : borderColor),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.arrow_down, size: 16.sp, color: _alertType == RateAlertType.below ? AppColors.success : textSecondary),
                          SizedBox(width: 4.w),
                          Text(
                            widget.l10n.rateDrops,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: _alertType == RateAlertType.below ? FontWeight.w600 : FontWeight.normal,
                              color: _alertType == RateAlertType.below ? AppColors.success : textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _alertType = RateAlertType.above),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: _alertType == RateAlertType.above ? AppColors.danger.withValues(alpha: 0.1) : Colors.transparent,
                        border: Border.all(color: _alertType == RateAlertType.above ? AppColors.danger : borderColor),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.arrow_up, size: 16.sp, color: _alertType == RateAlertType.above ? AppColors.danger : textSecondary),
                          SizedBox(width: 4.w),
                          Text(
                            widget.l10n.rateRises,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: _alertType == RateAlertType.above ? FontWeight.w600 : FontWeight.normal,
                              color: _alertType == RateAlertType.above ? AppColors.danger : textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Target Rate
            AppSliderInput(
              label: widget.l10n.targetRate,
              value: _targetRate,
              min: 1,
              max: 25,
              divisions: 48,
              activeColor: _alertType == RateAlertType.below ? AppColors.success : AppColors.danger,
              valueFormatter: (v) => '${v.toStringAsFixed(1)}%',
              onChanged: (v) => setState(() => _targetRate = v),
            ),
            SizedBox(height: 24.h),

            // Add Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text(
                  widget.l10n.add,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20.h),
          ],
        ),
      ),
    );
  }

  String _getLoanTypeShort(RateLoanType type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case RateLoanType.homeLoan:
        return l10n.homeShort;
      case RateLoanType.personalLoan:
        return l10n.personalShort;
      case RateLoanType.carLoan:
        return l10n.carShort;
      case RateLoanType.savings:
        return l10n.savingsShort;
    }
  }

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pleaseEnterName)),
      );
      return;
    }

    final alert = RateAlert(
      name: name,
      type: _type,
      targetRate: _targetRate,
      alertType: _alertType,
    );

    widget.onAdd(alert);
  }
}

class _EditRatesSheet extends StatefulWidget {
  final List<MarketRate> rates;
  final Function(RateLoanType, double) onSave;
  final AppLocalizations l10n;

  const _EditRatesSheet({
    required this.rates,
    required this.onSave,
    required this.l10n,
  });

  @override
  State<_EditRatesSheet> createState() => _EditRatesSheetState();
}

class _EditRatesSheetState extends State<_EditRatesSheet> {
  late Map<RateLoanType, double> _rateValues;

  @override
  void initState() {
    super.initState();
    _rateValues = {
      for (final rate in widget.rates) rate.type: rate.rate,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              widget.l10n.editMarketRates,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: textPrimary),
            ),
            SizedBox(height: 20.h),

            ...RateLoanType.values.map((type) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: AppSliderInput(
                label: _getLoanTypeLabel(type),
                value: _rateValues[type] ?? 8.0,
                min: 1,
                max: 25,
                divisions: 48,
                activeColor: _getLoanTypeColor(type),
                valueFormatter: (v) => '${v.toStringAsFixed(2)}%',
                onChanged: (v) {
                  setState(() => _rateValues[type] = v);
                  widget.onSave(type, v);
                },
              ),
            )),

            SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20.h),
          ],
        ),
      ),
    );
  }

  String _getLoanTypeLabel(RateLoanType type) {
    switch (type) {
      case RateLoanType.homeLoan:
        return widget.l10n.homeLoan;
      case RateLoanType.personalLoan:
        return widget.l10n.personalLoan;
      case RateLoanType.carLoan:
        return widget.l10n.carLoan;
      case RateLoanType.savings:
        return widget.l10n.savingsRate;
    }
  }

  Color _getLoanTypeColor(RateLoanType type) {
    switch (type) {
      case RateLoanType.homeLoan:
        return AppColors.primary;
      case RateLoanType.personalLoan:
        return AppColors.info;
      case RateLoanType.carLoan:
        return AppColors.warning;
      case RateLoanType.savings:
        return AppColors.success;
    }
  }
}

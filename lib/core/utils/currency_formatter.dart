import 'package:intl/intl.dart';

/// Vietnamese currency formatter utility
/// Supports:
/// - Full format: 1.000.000 đ
/// - Short format: 1tr (1 million), 1tỷ (1 billion)
class CurrencyFormatter {
  CurrencyFormatter._();

  // Vietnamese number format (dot as thousand separator)
  static final _fullFormat = NumberFormat('#,###', 'vi_VN');

  /// Format full currency: 1.000.000 đ
  static String format(double value, {bool showSymbol = true}) {
    final formatted = _fullFormat.format(value);
    return showSymbol ? '$formatted đ' : formatted;
  }

  /// Format short: 1tr = 1 million, 1tỷ = 1 billion
  static String formatShort(double value, {bool showSymbol = true}) {
    String result;

    if (value.abs() >= 1000000000) {
      // Billion (tỷ)
      final billions = value / 1000000000;
      result = '${_formatDecimal(billions)}tỷ';
    } else if (value.abs() >= 1000000) {
      // Million (triệu/tr)
      final millions = value / 1000000;
      result = '${_formatDecimal(millions)}tr';
    } else if (value.abs() >= 1000) {
      // Thousand (nghìn/k)
      final thousands = value / 1000;
      result = '${_formatDecimal(thousands)}k';
    } else {
      result = value.toStringAsFixed(0);
    }

    return showSymbol ? '$result đ' : result;
  }

  /// Format for input display (with thousand separators)
  static String formatForInput(double value) {
    return _fullFormat.format(value);
  }

  /// Parse formatted input back to double
  static double? parse(String input) {
    try {
      // Remove all non-numeric characters except decimal point
      final cleaned = input
          .replaceAll(RegExp(r'[^\d,.]'), '')
          .replaceAll('.', '') // Remove thousand separators (dot in VN)
          .replaceAll(',', '.'); // Convert decimal separator if needed

      return double.tryParse(cleaned);
    } catch (e) {
      return null;
    }
  }

  /// Parse short format: "1tr" -> 1000000, "5tỷ" -> 5000000000
  static double? parseShort(String input) {
    try {
      final cleaned = input.toLowerCase().trim();

      if (cleaned.endsWith('tỷ') || cleaned.endsWith('ty')) {
        final num = double.parse(
            cleaned.replaceAll('tỷ', '').replaceAll('ty', '').trim());
        return num * 1000000000;
      } else if (cleaned.endsWith('tr')) {
        final num = double.parse(cleaned.replaceAll('tr', '').trim());
        return num * 1000000;
      } else if (cleaned.endsWith('k')) {
        final num = double.parse(cleaned.replaceAll('k', '').trim());
        return num * 1000;
      }

      return double.tryParse(cleaned);
    } catch (e) {
      return null;
    }
  }

  /// Format percentage
  static String formatPercent(double value, {int decimals = 2}) {
    return '${value.toStringAsFixed(decimals)}%';
  }

  /// Format term in months to human readable
  static String formatTerm(int months) {
    if (months >= 12) {
      final years = months ~/ 12;
      final remainingMonths = months % 12;
      if (remainingMonths == 0) {
        return '$years năm';
      }
      return '$years năm $remainingMonths tháng';
    }
    return '$months tháng';
  }

  /// Format term in months to short form
  static String formatTermShort(int months) {
    if (months >= 12) {
      final years = months ~/ 12;
      final remainingMonths = months % 12;
      if (remainingMonths == 0) {
        return '${years}y';
      }
      return '${years}y ${remainingMonths}m';
    }
    return '${months}m';
  }

  /// Format compact for tables (shorter than formatShort)
  static String formatCompact(double value) {
    if (value.abs() >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}B';
    } else if (value.abs() >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value.abs() >= 1000) {
      return '${(value / 1000).toStringAsFixed(0)}K';
    }
    return value.toStringAsFixed(0);
  }

  static String _formatDecimal(double value) {
    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(1);
  }
}

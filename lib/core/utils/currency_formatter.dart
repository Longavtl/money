import 'package:intl/intl.dart';

/// Number system type for different regions
enum NumberSystem {
  western, // K, M, B (1000, 1M, 1B)
  eastAsian, // 万, 亿 (10K, 100M)
  indian, // K, Lakh, Crore (1K, 100K, 10M)
}

/// Currency configuration for each language
class CurrencyConfig {
  final String code;
  final String symbol;
  final String locale;
  final bool symbolBefore;
  final NumberSystem numberSystem;

  // Unit labels (meaning varies by number system)
  final String unit4; // 万/10K for eastAsian, Lakh for indian, K for western
  final String unit6; // not used for eastAsian, M for western
  final String unit7; // Crore for indian
  final String unit8; // 亿/100M for eastAsian
  final String unit9; // B for western, Arab for indian

  final String year;
  final String month;

  // Default amounts for this currency (for sliders/inputs)
  final double defaultLoanMin;
  final double defaultLoanMax;
  final double defaultLoanStep;
  final double defaultLoan; // typical loan amount
  final double defaultSavings; // typical savings goal

  const CurrencyConfig({
    required this.code,
    required this.symbol,
    required this.locale,
    this.symbolBefore = true,
    this.numberSystem = NumberSystem.western,
    this.unit4 = 'K',
    this.unit6 = 'M',
    this.unit7 = '',
    this.unit8 = '',
    this.unit9 = 'B',
    required this.year,
    required this.month,
    this.defaultLoanMin = 1000,
    this.defaultLoanMax = 1000000,
    this.defaultLoanStep = 1000,
    this.defaultLoan = 100000,
    this.defaultSavings = 10000,
  });
}

/// Multi-currency formatter utility
/// Supports locale-based formatting for:
/// - Full format: $1,000,000 or 1.000.000 đ
/// - Short format: 1M, 1K or 1triệu, 1tỷ
class CurrencyFormatter {
  CurrencyFormatter._();

  static String _currentLocale = 'en';

  /// Currency configurations by language code
  static const Map<String, CurrencyConfig> _configs = {
    // USD: $10K - $1M, typical $200K
    'en': CurrencyConfig(
      code: 'USD',
      symbol: '\$',
      locale: 'en_US',
      symbolBefore: true,
      numberSystem: NumberSystem.western,
      unit4: 'K',
      unit6: 'M',
      unit9: 'B',
      year: 'year',
      month: 'month',
      defaultLoanMin: 10000,
      defaultLoanMax: 1000000,
      defaultLoanStep: 5000,
      defaultLoan: 200000,
      defaultSavings: 20000,
    ),
    // VND: 50 triệu - 10 tỷ, typical 500 triệu
    'vi': CurrencyConfig(
      code: 'VND',
      symbol: 'đ',
      locale: 'vi_VN',
      symbolBefore: false,
      numberSystem: NumberSystem.western,
      unit4: 'nghìn',
      unit6: 'triệu',
      unit9: 'tỷ',
      year: 'năm',
      month: 'tháng',
      defaultLoanMin: 50000000,
      defaultLoanMax: 10000000000,
      defaultLoanStep: 10000000,
      defaultLoan: 500000000,
      defaultSavings: 50000000,
    ),
    // CNY: ¥50K - ¥5M, typical ¥500K
    'zh': CurrencyConfig(
      code: 'CNY',
      symbol: '¥',
      locale: 'zh_CN',
      symbolBefore: true,
      numberSystem: NumberSystem.eastAsian,
      unit4: '万',
      unit8: '亿',
      year: '年',
      month: '月',
      defaultLoanMin: 50000,
      defaultLoanMax: 5000000,
      defaultLoanStep: 10000,
      defaultLoan: 500000,
      defaultSavings: 50000,
    ),
    // JPY: ¥1M - ¥100M, typical ¥30M (1 JPY ≈ 0.007 USD)
    'ja': CurrencyConfig(
      code: 'JPY',
      symbol: '¥',
      locale: 'ja_JP',
      symbolBefore: true,
      numberSystem: NumberSystem.eastAsian,
      unit4: '万',
      unit8: '億',
      year: '年',
      month: 'ヶ月',
      defaultLoanMin: 1000000,
      defaultLoanMax: 100000000,
      defaultLoanStep: 1000000,
      defaultLoan: 30000000,
      defaultSavings: 3000000,
    ),
    // KRW: ₩10M - ₩1B, typical ₩300M (1 KRW ≈ 0.00075 USD)
    'ko': CurrencyConfig(
      code: 'KRW',
      symbol: '₩',
      locale: 'ko_KR',
      symbolBefore: true,
      numberSystem: NumberSystem.eastAsian,
      unit4: '만',
      unit8: '억',
      year: '년',
      month: '개월',
      defaultLoanMin: 10000000,
      defaultLoanMax: 1000000000,
      defaultLoanStep: 10000000,
      defaultLoan: 300000000,
      defaultSavings: 30000000,
    ),
    // EUR: €10K - €1M, typical €150K
    'es': CurrencyConfig(
      code: 'EUR',
      symbol: '€',
      locale: 'es_ES',
      symbolBefore: false,
      numberSystem: NumberSystem.western,
      unit4: 'K',
      unit6: 'M',
      unit9: 'MM',
      year: 'año',
      month: 'mes',
      defaultLoanMin: 10000,
      defaultLoanMax: 1000000,
      defaultLoanStep: 5000,
      defaultLoan: 150000,
      defaultSavings: 15000,
    ),
    'fr': CurrencyConfig(
      code: 'EUR',
      symbol: '€',
      locale: 'fr_FR',
      symbolBefore: false,
      numberSystem: NumberSystem.western,
      unit4: 'K',
      unit6: 'M',
      unit9: 'Md',
      year: 'an',
      month: 'mois',
      defaultLoanMin: 10000,
      defaultLoanMax: 1000000,
      defaultLoanStep: 5000,
      defaultLoan: 150000,
      defaultSavings: 15000,
    ),
    'de': CurrencyConfig(
      code: 'EUR',
      symbol: '€',
      locale: 'de_DE',
      symbolBefore: false,
      numberSystem: NumberSystem.western,
      unit4: 'K',
      unit6: 'Mio',
      unit9: 'Mrd',
      year: 'Jahr',
      month: 'Monat',
      defaultLoanMin: 10000,
      defaultLoanMax: 1000000,
      defaultLoanStep: 5000,
      defaultLoan: 150000,
      defaultSavings: 15000,
    ),
    // BRL: R$20K - R$2M, typical R$300K
    'pt': CurrencyConfig(
      code: 'BRL',
      symbol: 'R\$',
      locale: 'pt_BR',
      symbolBefore: true,
      numberSystem: NumberSystem.western,
      unit4: 'mil',
      unit6: 'mi',
      unit9: 'bi',
      year: 'ano',
      month: 'mês',
      defaultLoanMin: 20000,
      defaultLoanMax: 2000000,
      defaultLoanStep: 10000,
      defaultLoan: 300000,
      defaultSavings: 30000,
    ),
    // IDR: Rp50jt - Rp5M (5 tỷ), typical Rp500jt
    'id': CurrencyConfig(
      code: 'IDR',
      symbol: 'Rp',
      locale: 'id_ID',
      symbolBefore: true,
      numberSystem: NumberSystem.western,
      unit4: 'rb',
      unit6: 'jt',
      unit9: 'M',
      year: 'tahun',
      month: 'bulan',
      defaultLoanMin: 50000000,
      defaultLoanMax: 5000000000,
      defaultLoanStep: 10000000,
      defaultLoan: 500000000,
      defaultSavings: 50000000,
    ),
    // THB: ฿100K - ฿20M, typical ฿3M
    'th': CurrencyConfig(
      code: 'THB',
      symbol: '฿',
      locale: 'th_TH',
      symbolBefore: true,
      numberSystem: NumberSystem.western,
      unit4: 'พัน',
      unit6: 'ล้าน',
      unit9: 'พันล้าน',
      year: 'ปี',
      month: 'เดือน',
      defaultLoanMin: 100000,
      defaultLoanMax: 20000000,
      defaultLoanStep: 100000,
      defaultLoan: 3000000,
      defaultSavings: 300000,
    ),
    // INR: ₹5L - ₹5Cr, typical ₹50L
    'hi': CurrencyConfig(
      code: 'INR',
      symbol: '₹',
      locale: 'hi_IN',
      symbolBefore: true,
      numberSystem: NumberSystem.indian,
      unit4: 'K',
      unit6: 'लाख', // 1 lakh = 100,000
      unit7: 'करोड़', // 1 crore = 10,000,000
      unit9: 'अरब', // 1 arab = 1,000,000,000
      year: 'वर्ष',
      month: 'महीना',
      defaultLoanMin: 500000,
      defaultLoanMax: 50000000,
      defaultLoanStep: 100000,
      defaultLoan: 5000000,
      defaultSavings: 500000,
    ),
  };

  /// Get current currency config
  static CurrencyConfig get _config =>
      _configs[_currentLocale] ?? _configs['en']!;

  /// Set the current locale (call this when language changes)
  static void setLocale(String languageCode) {
    _currentLocale = languageCode;
  }

  /// Get number format for current locale
  static NumberFormat get _numberFormat =>
      NumberFormat('#,###', _config.locale);

  /// Format full currency: $1,000,000 or 1.000.000 đ
  static String format(double value, {bool showSymbol = true}) {
    final formatted = _numberFormat.format(value);
    if (!showSymbol) return formatted;

    if (_config.symbolBefore) {
      return '${_config.symbol}$formatted';
    } else {
      return '$formatted ${_config.symbol}';
    }
  }

  /// Format short: 1M, 1K or 1triệu, 1tỷ (locale-aware number systems)
  static String formatShort(double value, {bool showSymbol = true}) {
    String result;
    final config = _config;

    switch (config.numberSystem) {
      case NumberSystem.eastAsian:
        result = _formatEastAsian(value, config);
      case NumberSystem.indian:
        result = _formatIndian(value, config);
      case NumberSystem.western:
        result = _formatWestern(value, config);
    }

    if (!showSymbol) return result;

    if (config.symbolBefore) {
      return '${config.symbol}$result';
    } else {
      return '$result ${config.symbol}';
    }
  }

  /// Western format: K (1,000), M (1,000,000), B (1,000,000,000)
  static String _formatWestern(double value, CurrencyConfig config) {
    if (value.abs() >= 1000000000) {
      final billions = value / 1000000000;
      return '${_formatDecimal(billions)}${config.unit9}';
    } else if (value.abs() >= 1000000) {
      final millions = value / 1000000;
      return '${_formatDecimal(millions)}${config.unit6}';
    } else if (value.abs() >= 1000) {
      final thousands = value / 1000;
      return '${_formatDecimal(thousands)}${config.unit4}';
    }
    return value.toStringAsFixed(0);
  }

  /// East Asian format: 万 (10,000), 亿 (100,000,000)
  static String _formatEastAsian(double value, CurrencyConfig config) {
    if (value.abs() >= 100000000) {
      // 亿/億/억 = 100,000,000
      final yi = value / 100000000;
      return '${_formatDecimal(yi)}${config.unit8}';
    } else if (value.abs() >= 10000) {
      // 万/만 = 10,000
      final wan = value / 10000;
      return '${_formatDecimal(wan)}${config.unit4}';
    }
    return value.toStringAsFixed(0);
  }

  /// Indian format: K (1,000), Lakh (100,000), Crore (10,000,000), Arab (1,000,000,000)
  static String _formatIndian(double value, CurrencyConfig config) {
    if (value.abs() >= 1000000000) {
      // Arab = 1,000,000,000
      final arab = value / 1000000000;
      return '${_formatDecimal(arab)}${config.unit9}';
    } else if (value.abs() >= 10000000) {
      // Crore = 10,000,000
      final crore = value / 10000000;
      return '${_formatDecimal(crore)}${config.unit7}';
    } else if (value.abs() >= 100000) {
      // Lakh = 100,000
      final lakh = value / 100000;
      return '${_formatDecimal(lakh)}${config.unit6}';
    } else if (value.abs() >= 1000) {
      final thousands = value / 1000;
      return '${_formatDecimal(thousands)}${config.unit4}';
    }
    return value.toStringAsFixed(0);
  }

  /// Format for input display (with thousand separators)
  static String formatForInput(double value) {
    return _numberFormat.format(value);
  }

  /// Parse formatted input back to double
  static double? parse(String input) {
    try {
      // Remove currency symbols and non-numeric characters except decimal separators
      String cleaned = input
          .replaceAll(_config.symbol, '')
          .replaceAll(RegExp(r'[^\d,.]'), '')
          .trim();

      // Handle different decimal/thousand separators based on locale
      if (_currentLocale == 'vi' ||
          _currentLocale == 'de' ||
          _currentLocale == 'fr' ||
          _currentLocale == 'es' ||
          _currentLocale == 'pt' ||
          _currentLocale == 'id') {
        // These locales use dot as thousand separator, comma as decimal
        cleaned = cleaned.replaceAll('.', '').replaceAll(',', '.');
      } else {
        // English-style: comma as thousand separator, dot as decimal
        cleaned = cleaned.replaceAll(',', '');
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

  /// Format term in months to human readable (localized)
  static String formatTerm(int months) {
    final config = _config;
    if (months >= 12) {
      final years = months ~/ 12;
      final remainingMonths = months % 12;
      if (remainingMonths == 0) {
        return '$years ${config.year}';
      }
      return '$years ${config.year} $remainingMonths ${config.month}';
    }
    return '$months ${config.month}';
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

  /// Format compact for tables (shorter than formatShort) - always uses western format
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

  /// Get current currency symbol
  static String get symbol => _config.symbol;

  /// Get current currency code (e.g., USD, VND)
  static String get currencyCode => _config.code;

  /// Get default loan amount range for current currency
  static double get defaultLoanMin => _config.defaultLoanMin;
  static double get defaultLoanMax => _config.defaultLoanMax;
  static double get defaultLoanStep => _config.defaultLoanStep;
  static double get defaultLoan => _config.defaultLoan;
  static double get defaultSavings => _config.defaultSavings;

  static String _formatDecimal(double value) {
    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(1);
  }
}

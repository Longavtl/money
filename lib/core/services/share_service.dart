import 'package:share_plus/share_plus.dart';

import 'package:money_mate/core/utils/currency_formatter.dart';
import 'package:money_mate/domain/entities/calculation_results.dart';

/// Share service for sharing calculation results
class ShareService {
  /// Share loan calculation result as text
  static Future<void> shareLoanResult(LoanResult loan) async {
    final text = _buildLoanText(loan);
    await SharePlus.instance.share(ShareParams(
      text: text,
      subject: 'MoneyMate - Kết quả tính khoản vay',
    ));
  }

  /// Share savings calculation result as text
  static Future<void> shareSavingsResult(SavingsResult savings) async {
    final text = _buildSavingsText(savings);
    await SharePlus.instance.share(ShareParams(
      text: text,
      subject: 'MoneyMate - Kết quả tính tiết kiệm',
    ));
  }

  /// Share simple interest calculation result
  static Future<void> shareSimpleInterestResult(
      SimpleInterestResult result) async {
    final text = _buildSimpleInterestText(result);
    await SharePlus.instance.share(ShareParams(
      text: text,
      subject: 'MoneyMate - Kết quả tính lãi đơn',
    ));
  }

  /// Share compound interest calculation result
  static Future<void> shareCompoundInterestResult(
      CompoundInterestResult result) async {
    final text = _buildCompoundInterestText(result);
    await SharePlus.instance.share(ShareParams(
      text: text,
      subject: 'MoneyMate - Kết quả tính lãi kép',
    ));
  }

  static String _buildLoanText(LoanResult loan) {
    final buffer = StringBuffer();
    buffer.writeln('📊 KẾT QUẢ TÍNH KHOẢN VAY');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln();
    buffer.writeln('💰 Số tiền vay: ${CurrencyFormatter.format(loan.principal)}');
    buffer.writeln('📈 Lãi suất: ${loan.rate}%/năm');
    buffer.writeln('📅 Kỳ hạn: ${loan.termMonths} tháng (${loan.termYears} năm)');
    buffer.writeln('📋 Phương thức: ${loan.type.displayNameVi}');
    buffer.writeln();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('💵 Trả hàng tháng: ${CurrencyFormatter.format(loan.monthlyPayment)}');
    buffer.writeln('💳 Tổng trả: ${CurrencyFormatter.format(loan.totalPayment)}');
    buffer.writeln('📊 Tổng lãi: ${CurrencyFormatter.format(loan.totalInterest)}');
    buffer.writeln('📉 Tỷ lệ lãi/gốc: ${loan.interestPercentage.toStringAsFixed(1)}%');
    buffer.writeln();
    buffer.writeln('---');
    buffer.writeln('Tính toán bởi MoneyMate 🧮');
    return buffer.toString();
  }

  static String _buildSavingsText(SavingsResult savings) {
    final buffer = StringBuffer();
    buffer.writeln('📊 KẾT QUẢ TÍNH TIẾT KIỆM');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln();
    buffer.writeln('💰 Gửi ban đầu: ${CurrencyFormatter.format(savings.initialDeposit)}');
    buffer.writeln('💵 Gửi hàng tháng: ${CurrencyFormatter.format(savings.monthlyDeposit)}');
    buffer.writeln('📈 Lãi suất: ${savings.rate}%/năm');
    buffer.writeln('📅 Kỳ hạn: ${savings.termMonths} tháng (${savings.termYears} năm)');
    buffer.writeln('📋 Loại: ${savings.type.displayNameVi}');
    buffer.writeln();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('🏆 Giá trị cuối kỳ: ${CurrencyFormatter.format(savings.finalValue)}');
    buffer.writeln('💳 Tổng gửi: ${CurrencyFormatter.format(savings.totalDeposited)}');
    buffer.writeln('📊 Tổng lãi: ${CurrencyFormatter.format(savings.totalInterest)}');
    buffer.writeln('📈 Lợi nhuận: ${savings.returnPercentage.toStringAsFixed(1)}%');
    buffer.writeln();
    buffer.writeln('---');
    buffer.writeln('Tính toán bởi MoneyMate 🧮');
    return buffer.toString();
  }

  static String _buildSimpleInterestText(SimpleInterestResult result) {
    final buffer = StringBuffer();
    buffer.writeln('📊 KẾT QUẢ TÍNH LÃI ĐƠN');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln();
    buffer.writeln('💰 Gốc: ${CurrencyFormatter.format(result.principal)}');
    buffer.writeln('📈 Lãi suất: ${result.rate}%/năm');
    buffer.writeln('📅 Kỳ hạn: ${result.termMonths} tháng');
    buffer.writeln();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('💵 Tiền lãi: ${CurrencyFormatter.format(result.interest)}');
    buffer.writeln('🏆 Tổng tiền: ${CurrencyFormatter.format(result.totalAmount)}');
    buffer.writeln();
    buffer.writeln('---');
    buffer.writeln('Tính toán bởi MoneyMate 🧮');
    return buffer.toString();
  }

  static String _buildCompoundInterestText(CompoundInterestResult result) {
    final buffer = StringBuffer();
    buffer.writeln('📊 KẾT QUẢ TÍNH LÃI KÉP');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln();
    buffer.writeln('💰 Gốc: ${CurrencyFormatter.format(result.principal)}');
    buffer.writeln('📈 Lãi suất: ${result.rate}%/năm');
    buffer.writeln('📅 Kỳ hạn: ${result.termMonths} tháng');
    buffer.writeln('🔄 Chu kỳ ghép: ${result.frequency.displayNameVi}');
    buffer.writeln();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('💵 Tiền lãi: ${CurrencyFormatter.format(result.interest)}');
    buffer.writeln('🏆 Tổng tiền: ${CurrencyFormatter.format(result.totalAmount)}');
    buffer.writeln('📊 Lãi suất thực: ${result.effectiveAnnualRate.toStringAsFixed(2)}%');
    buffer.writeln();
    buffer.writeln('---');
    buffer.writeln('Tính toán bởi MoneyMate 🧮');
    return buffer.toString();
  }
}

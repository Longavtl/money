import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/calculation_results.dart';

/// PDF Export Service for generating financial reports
class PdfExportService {
  /// Generate and share/print a loan report
  static Future<void> exportLoanReport(LoanResult loan) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => _buildHeader('BÁO CÁO KHOẢN VAY'),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          _buildLoanSummary(loan),
          pw.SizedBox(height: 20),
          _buildLoanDetails(loan),
          pw.SizedBox(height: 20),
          _buildAmortizationTable(loan),
        ],
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'loan_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }

  /// Generate and share/print a savings report
  static Future<void> exportSavingsReport(SavingsResult savings) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => _buildHeader('BÁO CÁO TIẾT KIỆM'),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          _buildSavingsSummary(savings),
          pw.SizedBox(height: 20),
          _buildSavingsDetails(savings),
          pw.SizedBox(height: 20),
          _buildGrowthTable(savings),
        ],
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'savings_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }

  static pw.Widget _buildHeader(String title) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Money Nest',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.blue800,
              ),
            ),
            pw.Text(
              _formatDate(DateTime.now()),
              style: const pw.TextStyle(
                fontSize: 12,
                color: PdfColors.grey600,
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 8),
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.symmetric(vertical: 12),
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: PdfColors.blue800, width: 2),
            ),
          ),
          child: pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.SizedBox(height: 20),
      ],
    );
  }

  static pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 10),
      child: pw.Text(
        'Trang ${context.pageNumber} / ${context.pagesCount}',
        style: const pw.TextStyle(
          fontSize: 10,
          color: PdfColors.grey600,
        ),
      ),
    );
  }

  static pw.Widget _buildLoanSummary(LoanResult loan) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'TỔNG QUAN',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue800,
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            children: [
              pw.Expanded(
                child: _buildSummaryItem(
                  'Trả hàng tháng',
                  CurrencyFormatter.format(loan.monthlyPayment),
                  isHighlight: true,
                ),
              ),
              pw.Expanded(
                child: _buildSummaryItem(
                  'Tổng trả',
                  CurrencyFormatter.format(loan.totalPayment),
                ),
              ),
              pw.Expanded(
                child: _buildSummaryItem(
                  'Tổng lãi',
                  CurrencyFormatter.format(loan.totalInterest),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildLoanDetails(LoanResult loan) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey100),
          children: [
            _buildTableHeader('Thông tin'),
            _buildTableHeader('Giá trị'),
          ],
        ),
        _buildTableRow('Số tiền vay', CurrencyFormatter.format(loan.principal)),
        _buildTableRow('Lãi suất', '${loan.rate}%/năm'),
        _buildTableRow(
            'Kỳ hạn', '${loan.termMonths} tháng (${loan.termYears} năm)'),
        _buildTableRow('Phương thức', loan.type.displayNameVi),
        _buildTableRow(
            'Tỷ lệ lãi/gốc', '${loan.interestPercentage.toStringAsFixed(1)}%'),
      ],
    );
  }

  static pw.Widget _buildAmortizationTable(LoanResult loan) {
    final yearlyData = loan.yearlySummary;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'LỊCH TRẢ NỢ THEO NĂM',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(2),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(2),
          },
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey100),
              children: [
                _buildTableHeader('Năm'),
                _buildTableHeader('Gốc đã trả'),
                _buildTableHeader('Lãi đã trả'),
                _buildTableHeader('Tổng'),
              ],
            ),
            ...yearlyData.map((y) => pw.TableRow(
                  children: [
                    _buildTableCell('Năm ${y.year}'),
                    _buildTableCell(
                        CurrencyFormatter.formatShort(y.principalPaid)),
                    _buildTableCell(
                        CurrencyFormatter.formatShort(y.interestPaid)),
                    _buildTableCell(CurrencyFormatter.formatShort(y.total)),
                  ],
                )),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildSavingsSummary(SavingsResult savings) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.green50,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'TỔNG QUAN',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green800,
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            children: [
              pw.Expanded(
                child: _buildSummaryItem(
                  'Giá trị cuối kỳ',
                  CurrencyFormatter.format(savings.finalValue),
                  isHighlight: true,
                ),
              ),
              pw.Expanded(
                child: _buildSummaryItem(
                  'Tổng gửi',
                  CurrencyFormatter.format(savings.totalDeposited),
                ),
              ),
              pw.Expanded(
                child: _buildSummaryItem(
                  'Tổng lãi',
                  CurrencyFormatter.format(savings.totalInterest),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSavingsDetails(SavingsResult savings) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey100),
          children: [
            _buildTableHeader('Thông tin'),
            _buildTableHeader('Giá trị'),
          ],
        ),
        _buildTableRow(
            'Gửi ban đầu', CurrencyFormatter.format(savings.initialDeposit)),
        _buildTableRow(
            'Gửi hàng tháng', CurrencyFormatter.format(savings.monthlyDeposit)),
        _buildTableRow('Lãi suất', '${savings.rate}%/năm'),
        _buildTableRow(
            'Kỳ hạn', '${savings.termMonths} tháng (${savings.termYears} năm)'),
        _buildTableRow('Loại tiết kiệm', savings.type.displayNameVi),
        _buildTableRow(
            'Lợi nhuận', '${savings.returnPercentage.toStringAsFixed(1)}%'),
      ],
    );
  }

  static pw.Widget _buildGrowthTable(SavingsResult savings) {
    // Sample yearly growth
    final yearlyPoints = <GrowthDataPoint>[];
    for (int i = 0; i < savings.growthData.length; i += 12) {
      yearlyPoints.add(savings.growthData[i]);
    }
    // Add last point
    if (savings.growthData.isNotEmpty &&
        (savings.growthData.length - 1) % 12 != 0) {
      yearlyPoints.add(savings.growthData.last);
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'TĂNG TRƯỞNG THEO NĂM',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(2),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(2),
          },
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey100),
              children: [
                _buildTableHeader('Tháng'),
                _buildTableHeader('Số dư'),
                _buildTableHeader('Tổng gốc'),
                _buildTableHeader('Tổng lãi'),
              ],
            ),
            ...yearlyPoints.map((p) => pw.TableRow(
                  children: [
                    _buildTableCell('${p.month}'),
                    _buildTableCell(CurrencyFormatter.formatShort(p.balance)),
                    _buildTableCell(CurrencyFormatter.formatShort(p.principal)),
                    _buildTableCell(CurrencyFormatter.formatShort(p.interest)),
                  ],
                )),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildSummaryItem(String label, String value,
      {bool isHighlight = false}) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: const pw.TextStyle(
            fontSize: 10,
            color: PdfColors.grey700,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: isHighlight ? 16 : 14,
            fontWeight: pw.FontWeight.bold,
            color: isHighlight ? PdfColors.blue800 : PdfColors.black,
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildTableHeader(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  static pw.TableRow _buildTableRow(String label, String value) {
    return pw.TableRow(
      children: [
        _buildTableCell(label),
        _buildTableCell(value),
      ],
    );
  }

  static pw.Widget _buildTableCell(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 10),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

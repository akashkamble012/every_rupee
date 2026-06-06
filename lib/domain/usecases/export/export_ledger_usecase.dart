import 'dart:io';

import 'package:excel/excel.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../../core/error/app_error.dart';
import '../../../core/utils/formatters.dart';
import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

enum ExportFormat { csv, excel, pdf }

@injectable
class ExportLedgerUseCase {
  final TransactionRepository _txRepo;
  final BudgetCategoryRepository _categoryRepo;

  ExportLedgerUseCase(this._txRepo, this._categoryRepo);

  Future<Result<void>> call(ExportFormat format) async {
    try {
      // 1. Fetch all transactions
      final result =
          await _txRepo.getTransactionsPaged(offset: 0, limit: 100000);
      if (result.isErr) return Err(result.error);

      final transactions = result.value;

      // 2. Fetch categories
      final catResult = await _categoryRepo.getAllCategories();
      final Map<String, String> categoryNames = {};
      if (catResult.isOk) {
        for (var c in catResult.value) {
          categoryNames[c.id] = c.name;
        }
      }

      // 3. Build data
      final headers = [
        'Date',
        'Type',
        'Category',
        'Amount',
        'Merchant',
        'Payment Mode',
        'Note',
        'Tags',
        'Is Recurring',
      ];

      List<List<dynamic>> rows = [];
      for (var tx in transactions) {
        rows.add([
          formatShortDate(tx.date),
          tx.type == TransactionType.debit ? 'Debit' : 'Credit',
          categoryNames[tx.categoryId] ?? 'Unknown',
          tx.amount,
          tx.merchant ?? '',
          tx.paymentMode?.name ?? '',
          tx.note ?? '',
          tx.tags.join(', '),
          tx.isRecurring ? 'Yes' : 'No',
        ]);
      }

      final tempDir = await getTemporaryDirectory();
      File? file;

      switch (format) {
        case ExportFormat.csv:
          List<List<dynamic>> csvRows = [headers, ...rows];
          String csv = const ListToCsvConverter().convert(csvRows);
          file = File(
              '${tempDir.path}/ledger_export_${DateTime.now().millisecondsSinceEpoch}.csv');
          await file.writeAsString(csv);
          break;
        case ExportFormat.excel:
          var excel = Excel.createExcel();
          var sheet = excel['Sheet1'];
          sheet.appendRow(headers.map((h) => TextCellValue(h)).toList());
          for (var row in rows) {
            sheet.appendRow(row.map((val) {
              if (val is double) return DoubleCellValue(val);
              if (val is int) return IntCellValue(val);
              return TextCellValue(val.toString());
            }).toList());
          }
          file = File(
              '${tempDir.path}/ledger_export_${DateTime.now().millisecondsSinceEpoch}.xlsx');
          final bytes = excel.encode();
          if (bytes != null) {
            await file.writeAsBytes(bytes);
          }
          break;
        case ExportFormat.pdf:
          final pdf = pw.Document();
          pdf.addPage(
            pw.MultiPage(
              pageFormat: PdfPageFormat.a4.landscape,
              build: (pw.Context context) {
                return [
                  pw.Header(
                      level: 0,
                      child: pw.Text('Ledger Export',
                          style: pw.TextStyle(
                              fontSize: 24, fontWeight: pw.FontWeight.bold))),
                  pw.TableHelper.fromTextArray(
                    context: context,
                    data: <List<String>>[
                      headers,
                      ...rows.map((r) => r.map((c) => c.toString()).toList()),
                    ],
                  ),
                ];
              },
            ),
          );
          file = File(
              '${tempDir.path}/ledger_export_${DateTime.now().millisecondsSinceEpoch}.pdf');
          await file.writeAsBytes(await pdf.save());
          break;
      }

      // 4. Share
      if (file != null) {
        await Share.shareXFiles([XFile(file.path)], text: 'My Ledger Export');
      }

      return const Ok(null);
    } catch (e) {
      return Err(
          AppError.unknown(message: 'Failed to export ledger', original: e));
    }
  }
}

class ListToCsvConverter {
  const ListToCsvConverter();

  String convert(List<List<dynamic>> rows) {
    return rows.map((row) {
      return row.map((cell) {
        final str = cell?.toString() ?? '';
        if (str.contains(',') || str.contains('"') || str.contains('\n')) {
          return '"${str.replaceAll('"', '""')}"';
        }
        return str;
      }).join(',');
    }).join('\n');
  }
}

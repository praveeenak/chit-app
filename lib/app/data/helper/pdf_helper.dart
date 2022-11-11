import 'dart:io';

import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../utils/utils.dart';

class PdfHelper {
  static final PdfHelper _instance = PdfHelper._internal();
  factory PdfHelper() => _instance;
  PdfHelper._internal();

  static Future<File> saveDocument({required String name, required Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    Utils.hideLoadingDialog();
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static Future<File> generateTransactionPdf({required PdfData data}) async {
    Utils.showLoadingDialog();
    final pdf = Document();
    final now = DateTime.now();
    final fileName = '${data.tId}.pdf';

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        mainAxisAlignment: MainAxisAlignment.center,
        build: (context) => [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('dd-MMMM-yyyy').format(now),
                  style: const TextStyle(color: PdfColors.black, fontSize: 16),
                ),
                SizedBox(height: 2),
                Text(
                  DateFormat('EEEE').format(now),
                  style: const TextStyle(color: PdfColors.black, fontSize: 16),
                ),
                SizedBox(height: 40),
                Text(
                  data.tId,
                  style: const TextStyle(color: PdfColors.black, fontSize: 26),
                ),
                SizedBox(height: 5),
                Text(
                  data.cId,
                  style: const TextStyle(color: PdfColors.grey, fontSize: 20),
                ),
                SizedBox(height: 40),
                Text(
                  data.cName,
                  style: const TextStyle(color: PdfColors.black, fontSize: 24),
                ),
                Text(
                  data.cPhone,
                  style: const TextStyle(color: PdfColors.black, fontSize: 22),
                ),
                SizedBox(height: 10),
                Divider(color: PdfColors.grey),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chitty Amount',
                      style: const TextStyle(color: PdfColors.grey, fontSize: 22),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Rs. ${data.amount}',
                      style: TextStyle(
                        color: PdfColors.black,
                        fontSize: 32,
                        fontBold: Font.courierBold(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return saveDocument(name: fileName, pdf: pdf);
  }
}

class PdfData {
  String tId;
  String cId;
  String cName;
  String cPhone;
  String amount;

  PdfData({
    required this.tId,
    required this.cId,
    required this.cName,
    required this.cPhone,
    required this.amount,
  });
}

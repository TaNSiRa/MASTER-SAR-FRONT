import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

void showPDF(String pdf64, BuildContext context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // หัวข้อ
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Preview PDF',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),
              ),

              // แสดง PDF
              Container(
                width: width * 0.45,
                height: height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: PdfPreview(
                    maxPageWidth: width * 0.45,
                    padding: const EdgeInsets.all(8),
                    actionBarTheme: PdfActionBarTheme(
                      backgroundColor: Colors.blueGrey[800],
                      iconColor: Colors.white,
                    ),
                    canChangePageFormat: false,
                    canChangeOrientation: false,
                    canDebug: false,
                    useActions: true,
                    build: (format) => base64Decode(pdf64),
                  ),
                ),
              ),

              // const SizedBox(height: 16),

              // ปุ่มปิด
              // ElevatedButton.icon(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   icon: const Icon(Icons.close, size: 20, color: Colors.red),
              //   label: const Text('Close'),
              //   style: ElevatedButton.styleFrom(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     backgroundColor: Colors.blueGrey[600],
              //     foregroundColor: Colors.white,
              //   ),
              // ),
            ],
          ),
        ),
      );
    },
  );
}

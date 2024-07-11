import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'widget/default_scaffold.dart';

// 참고 사이트
// https://github.com/DavBfr/dart_pdf/tree/master/demo

// 바이트 이미지 사용법
// import 'package:pdf/widgets.dart' as pw;

// ByteData _img = ByteData(0);

// Image.memory(_img.buffer.asUint8List())),
// 기본은 저렇게 사용하지만

// pw. 위젯에서 사용할려면
// final imageS = pw.MemoryImage(_img.buffer.asUint8List());
// 이렇게 파이널 변수를 생성 후

// pw.Image(imageS, width: 100, height: 200),
// 그걸 이미지위젯에 넣어주면 된다.

// 용지 여백 설정
// pdf.addPage(pw.Page(
// margin: const pw.EdgeInsets.only(top: 10, left: 20, right: 20),
// pageFormat: format,
// build: (pw.Context context) {
// margin 값을 수정하면 된다.

// Table.fromTextArray 사용한 예시 코드
// pw.Table.fromTextArray(
// cellAlignment: pw.Alignment.center,
// cellHeight: 70, data: const <List<String>>[
// <String>['테스트\n20  년  월  일\n이름\n별명'],
// <String>['테스트'],
// <String>['20  년  월  일'],
// <String>['이름\n별명'],
// ]),

final controller = TextEditingController();
String setText = '텍스트';

class PdfPackageScreen extends StatefulWidget {
  const PdfPackageScreen({super.key});

  @override
  State<PdfPackageScreen> createState() => _PdfPackageScreenState();
}

class _PdfPackageScreenState extends State<PdfPackageScreen> {

  Future<String?> askName(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('입력해주세요'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          content: TextField(
            decoration: const InputDecoration(hintText: 'text'),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (controller.text != '') {
                  Navigator.pop(context, controller.text);
                }
                setState(() {
                  setText = controller.text;
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      appBar: AppBar(
        title: const Text('PDF Test'),
        leading: Builder(
          builder: (context) {
            return InkWell(
              onTap: () => askName(context),
              child: const Icon(Icons.add)
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Print Document',
        onPressed: () {
          Printing.layoutPdf(
            onLayout: (PdfPageFormat format) {
              return buildPdf(format);
            },
          );
        },
        child: const Icon(Icons.print),
      ),
      body: PdfPreview(
        build: (PdfPageFormat format) => buildPdf2(format),
        // actions: const [],
        // useActions: false, // 하단 버튼 활성화 여부
        canDebug: false, // 디버깅모드 활성화 여부
        canChangeOrientation: false, // 용지 방향 설정(가로, 세로)
        canChangePageFormat: false, //용지 크기 설정(ex A4)
        //allowPrinting: false,  //프린터 기능 활성화 여부
        //allowSharing: false, // 공유 기능 활성화 여부
        pageFormats: const <String, PdfPageFormat>{
          'A4': PdfPageFormat.a4,
        },
      ),
    );
  }
}

Future<Uint8List> buildPdf2(PdfPageFormat format) async {
  pw.ThemeData myTheme = pw.ThemeData.withFont(
    base: pw.Font.ttf(await rootBundle.load('assets/fonts/Freesentation-9Black.ttf')),
  );
  final pdf = pw.Document(theme: myTheme);
  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (pw.Context context) {
       return tenure();
      }
    )
  ); // Page
  return pdf.save();
}

pw.Widget tenure() {
  return pw.Column(
    children: [
      pw.Table(
        border: pw.TableBorder.all(),
        children: [
         pw.TableRow(
            children: [
              pw.Container(
               height: 50,
               child: pw.Center(child: pw.Text('Test PDF', style: pw.TextStyle(fontSize: 23)))
              )
            ]
          )
        ]
      ),
        pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: const {
            0: pw.FixedColumnWidth(70),
            1: pw.FixedColumnWidth(70),
            2: pw.FixedColumnWidth(70),
            3: pw.FixedColumnWidth(70),
          },
          children: [
           pw.TableRow(
            children: [
              pw.Container(
                color: PdfColors.grey300,
                height: 50,
                child: pw.Center(child: pw.Text('이름', style: const pw.TextStyle(fontSize: 14)))
              ),
              pw.Container(
                height: 50,
                child: pw.Center(child: pw.Text('', style: const pw.TextStyle(fontSize: 14)))
              ),
              pw.Container(
                color: PdfColors.grey300,
                height: 50,
                child: pw.Center(child: pw.Text('사업자번호', style: const pw.TextStyle(fontSize: 14)))
              ),
              pw.Container(
                height: 50,
                child: pw.Center(child: pw.Text('연동 정보', style: const pw.TextStyle(fontSize: 14)))
              ),
            ]
           )
          ]
        ),

        pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: const {
            0: pw.FixedColumnWidth(34),
            1: pw.FixedColumnWidth(102),
          },
          children: [
            pw.TableRow(
              children: [
               pw.Container(
                color: PdfColors.grey300,
                height: 50,
                child: pw.Center(child: pw.Text('입력', style: const pw.TextStyle(fontSize: 14)))
              ),
              pw.Container(
                height: 50,
                child: pw.Center(child: pw.Text(setText, style: const pw.TextStyle(fontSize: 14)))
              ),
             ]
            )
          ]
        ),
        pw.Container(
          width: double.infinity,
          height: 390,
          decoration: pw.BoxDecoration(border: pw.TableBorder.symmetric(outside: const pw.BorderSide(width: 1)),
        ),
        child: pw.Column(
         children: [
            pw.SizedBox(height: 50),
            //pw.Image(imageS),
          ]
        ),
      ),
    ]
  );
}

Future<Uint8List> buildPdf(PdfPageFormat format) async {
  final pw.Document doc = pw.Document();
  doc.addPage(
    pw.Page(
      pageFormat: format,
      build: (pw.Context context) {
        return pw.ConstrainedBox(
          constraints: const pw.BoxConstraints.expand(),
          child: pw.FittedBox(
            child: pw.Text('Hello World'),
          ),
        );
      },
    ),
  );
  return await doc.save();
}
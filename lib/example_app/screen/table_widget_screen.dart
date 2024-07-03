import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';

// 참고 사이트
// https://api.flutter.dev/flutter/material/DataTable-class.html
// https://terry1213.com/flutter/flutter-widget-of-the-week-table/

Color color119 = const Color.fromRGBO(119, 119, 119, 1);
Color color238 = const Color.fromRGBO(238, 238, 238, 1);
Color color250 = const Color.fromRGBO(250, 250, 250, 1);
Color color012985 = const Color.fromRGBO(0, 129, 85, 1);
Color color244252250 = const Color.fromRGBO(244, 252, 250, 1);

Map<int, TableColumnWidth> columnWidths = const {
  0: FlexColumnWidth(80),
  1: FlexColumnWidth(60),
  2: FlexColumnWidth(60),
  3: FlexColumnWidth(60),
  4: FlexColumnWidth(60),
};

TextStyle tableSum = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 20,
  color: color012985,
);

class TableWidgetScreen extends StatelessWidget {
  const TableWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Table(
              border: TableBorder(
                top: BorderSide(color: color238),
                horizontalInside: BorderSide(color: color238),
              ),
              columnWidths: columnWidths,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: BoxDecoration(color: color250,),
                  children: [
                    Container(height: 42, color: color250,),
                    Center(child: Text('11', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: color119),)),
                    Center(child: Text('22', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: color119),)),
                    Center(child: Text('33', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: color119),)),
                    Center(child: Text('44', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: color119),)),
                  ]
                ),
                for(int i=0; i<6; i++)
                TableRow(
                  children: [
                    Container(
                      height: 38,
                      color: color250,
                      child: Center(child: Text('1월', style: Theme.of(context).textTheme.titleLarge,))
                    ),
                    Center(child: Text('1', style: Theme.of(context).textTheme.titleLarge,)),
                    Center(child: Text('1', style: Theme.of(context).textTheme.titleLarge,)),
                    Center(child: Text('0', style: Theme.of(context).textTheme.titleLarge,)),
                    Center(child: Text('0', style: Theme.of(context).textTheme.titleLarge,)),
                  ]
                ),
              ],
            ),

            Table(
              border: TableBorder(
                top: BorderSide(color: color012985),
                bottom: BorderSide(color: color012985),
              ),
              columnWidths: columnWidths,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: BoxDecoration(color: color244252250,),
                  children: [
                    SizedBox(
                      height: 38,
                      child: Center(child: Text('합계', style: tableSum,))
                    ),
                    Center(child: Text('1', style: tableSum,)),
                    Center(child: Text('1', style: tableSum,)),
                    Center(child: Text('0', style: tableSum,)),
                    Center(child: Text('0', style: tableSum,)),
                  ]
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

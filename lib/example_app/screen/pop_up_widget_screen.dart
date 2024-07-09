import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'widget/default_scaffold.dart';
import 'widget/snack_bar_view.dart';

// 참고 사이트
// https://kyungsnim.net/77

class PopUpWidgetScreen extends StatefulWidget {
  const PopUpWidgetScreen({super.key});

  @override
  State<PopUpWidgetScreen> createState() => _PopUpWidgetScreenState();
}

class _PopUpWidgetScreenState extends State<PopUpWidgetScreen> {
  DateRangePickerController controllerDate = DateRangePickerController();

  @override
  void initState() {
    super.initState();
    controllerDate.view = DateRangePickerView.month;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: ElevatedButton(
                  onPressed: () => showDateWindow(context),
                  child: const Text('showDatePicker 달력')
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: ElevatedButton(
                  onPressed: () => showCalendar(
                    context: context,
                    controllerDate: controllerDate,
                    view: controllerDate.view!, //DateRangePickerView.month,
                    allowViewNavigation: true,
                    onSubmit: (value) {
                      if(value == null) {
                        snackBarView(context: context, message: '날짜를 선택해주세요.');
                      }
                      else {
                        String selDate = dateTimeFormat(format: 'yyyy-MM-dd', dateTime: value.toString());
                        print(selDate);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  child: const Text('syncfusion_flutter_datepicker 달력')
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // view 값 유동적으로 하는법
                    setState(() {
                      if(controllerDate.view == DateRangePickerView.month) {
                        controllerDate.view = DateRangePickerView.decade;
                      }
                      else {
                        controllerDate.view = DateRangePickerView.month;
                      }
                    });
                  },
                  child: const Text('달력 view 변경')
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () => showDialogWindow(context),
                child: const Text('showDialogAlertDialog)')
              )
            ),

            Container(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () => showTimePickerWindow(context),
                child: const Text('TimePicker')
              )
            ),

            Container(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () => datePickCupertino(context),
                child: const Text('datePickCupertino')
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () => datePickCupertino2(context, 11, 56),
                child: const Text('datePickCupertino2')
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () => timePick(context, 11, 56),
                child: const Text('timePick')
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showDateWindow(BuildContext context) {
  var date = DateTime.now();
  return showDatePicker(
    context: context,
    initialDate: DateTime(date.year, date.month, date.day),
    firstDate: DateTime(2023,1 ,1),
    lastDate: DateTime(date.year+1, date.month, date.day),
  );
}

DateTime today = DateTime.now();
DateTime maxDate = DateTime(DateTime.now().year+1, 12);
DateTime minDate = DateTime(2021);

// view: DateRangePickerView.year,
// 표시하고 싶은 달력 설정(year, month, century,  decade)

// allowViewNavigation: false,
// SfDateRangePicker 헤더 의 상호 작용을 통해 DateRangePickerView 간 보기 전환을 활성화 또는 비활성화하는 데 사용됩니다

// DateRangePickerController controller = DateRangePickerController();
// controller: controller,
// 컨트롤러를 추가해주면 선택한 날짜를 표시해준다
// 오늘날짜도 표시된다.

// sfdaterangepicker 월선택
// https://support.syncfusion.com/kb/article/9811/how-to-customize-the-month-cell-of-the-flutter-date-range-picker-sfdaterangepicker?_ga=2.229705820.1301892246.1687849073-2104096235.1687849073

Future<dynamic> showCalendar({
  required BuildContext context,
  required DateRangePickerController controllerDate,
  required DateRangePickerView view,
  required bool allowViewNavigation,
  DateTime? getMinDate,
  String? getDay,
  dynamic Function(Object?)? onSubmit,
}) async {
  showDialog<Widget>(
    context: context,
    builder: (BuildContext contexts) {
      return AlertDialog(
        content: SizedBox(
          width: 400,
          height: 400,
          child:  SfDateRangePicker(
            headerStyle: const DateRangePickerHeaderStyle(textStyle: TextStyle(fontSize: 16)),
            monthViewSettings: const DateRangePickerMonthViewSettings(
              viewHeaderStyle: DateRangePickerViewHeaderStyle(textStyle: TextStyle(fontSize: 16))
            ),
            yearCellStyle: const DateRangePickerYearCellStyle(
              textStyle: TextStyle(fontSize: 16),
              todayTextStyle: TextStyle(fontSize: 16),
              leadingDatesTextStyle: TextStyle(fontSize: 16),
              disabledDatesTextStyle: TextStyle(fontSize: 16),
            ),
            monthCellStyle: const DateRangePickerMonthCellStyle(
              textStyle: TextStyle(fontSize: 16),
              disabledDatesTextStyle: TextStyle(fontSize: 16),
              leadingDatesTextStyle: TextStyle(fontSize: 16),
              blackoutDateTextStyle: TextStyle(fontSize: 16),
              todayTextStyle: TextStyle(fontSize: 16),
              trailingDatesTextStyle: TextStyle(fontSize: 16),
            ),
            selectionTextStyle: const TextStyle(fontSize: 16),
            headerHeight: 40,
            controller: controllerDate,
            initialDisplayDate: getDay == null? today : DateTime.parse(getDay),
            initialSelectedDate: getDay == null? today : DateTime.parse(getDay),
            view: view,
            backgroundColor: Colors.white,
            showActionButtons: true,
            toggleDaySelection: true,
            allowViewNavigation: allowViewNavigation,
            maxDate: maxDate,
            minDate: getMinDate ?? minDate,
            onSubmit: onSubmit,
            onCancel: () {
              Navigator.of(contexts).pop();
            },
          ),
        ),
      );
    }
  );
}

String dateTimeFormat({String format = 'yyyy.MM.dd', required String dateTime}) {
  return DateFormat(format).format(DateTime.parse(dateTime)).toString();
}

// 참고 사이트
// https://dalgonakit.tistory.com/109
// https://stackoverflow.com/questions/53913192/flutter-how-to-change-the-width-of-an-alertdialog
Future showDialogWindow(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: const Text('타이틀'),
        // content 텍스트 길이에 따라 AlertDialog 박스 크기 조절 가능
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Text('내용'),
        ),
        actions: [
          ElevatedButton(
            onPressed: (){},
            child: const Text('아니요'),
          ),
          const SizedBox(width: 8,),
          ElevatedButton(
            onPressed: (){},
            child: const Text('네'),
          ),
        ],
        // actions 속성에 패딩 값
        actionsPadding: const EdgeInsets.all(20),
        // 대화상자 외부 패딩 값
        // insetPadding 사용할려면 컨텐츠 속성에 SizedBox,Container 위젯으로 감싼 후 width 값을 줘야한다.
        // ex) width: MediaQuery.of(context).size.width,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      );
    }
  );
}

// 참고 사이트
// https://velog.io/@qazws78941/Flutter-TimePicker
Future<TimeOfDay?> showTimePickerWindow(BuildContext context) {
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
}

// 참고 사이트
// https://velog.io/@adbr/flutter-Cupertino-iOS-style-datepicker-%EC%BF%A0%ED%8D%BC%ED%8B%B0%EB%85%B8-%EB%94%94%EC%9E%90%EC%9D%B8-datepicker-%EC%84%A4%EC%A0%95


void datePickCupertino(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      children: [
        Expanded(
          child: CupertinoDatePicker(
            minimumYear: 1900,
            maximumYear: DateTime.now().year,
            initialDateTime: DateTime.now(),
            maximumDate: DateTime.now(),
            onDateTimeChanged: (DateTime sel){
              print(sel);
            },
            mode: CupertinoDatePickerMode.date,
          ),
        ),
        Row(
          children: [
          Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('선택'),
              )
            ),
          ],
        ),
        const SizedBox(height: 10,),
      ],
    ),
  );
}

void datePickCupertino2(BuildContext context, int hours, int minutes) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      children: [
        Expanded(
          child: CupertinoDatePicker(
            initialDateTime: DateTime(2023, 9, 4, hours, minutes),
            onDateTimeChanged: (DateTime sel){
              print(sel);
            },
            mode: CupertinoDatePickerMode.time,
            use24hFormat: true,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('선택'),
              )
            ),
          ],
        ),
        const SizedBox(height: 10,),
      ],
    ),
  );
}

void timePick(BuildContext context, int hours, int minutes) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      children: [
        Expanded(
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            initialTimerDuration: Duration(hours: hours, minutes: minutes),
            onTimerDurationChanged: (Duration value) {
              print(value);
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('선택'),
              )
            ),
          ],
        ),
        const SizedBox(height: 20,),
      ],
    ),
  );
}
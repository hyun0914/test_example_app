import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'widget/default_scaffold.dart';
import 'widget/snack_bar_view.dart';


class DateRelatedScreen extends StatelessWidget {
  const DateRelatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 오늘 날짜 가져오는 법
    DateTime today = DateTime.now();
    snackBarView(context:context, message:'$today');

    String freeRemainingDays = '';
    String expDt = '2024-09-24 00:02:00';
    Duration diffTime = DateTime.parse(expDt).difference(today);
    int days = diffTime.inDays + 1;

    if(days > 1) {
      freeRemainingDays = '$days일';
    }
    else if(days == 1) {
      if(diffTime.inHours == 0) {
        if(diffTime.inMinutes == 0) {
          freeRemainingDays = '${diffTime.inSeconds - (diffTime.inMinutes * 60)}초 남음';
        }
        else {
          freeRemainingDays = '${diffTime.inMinutes - (diffTime.inHours * 60)}분 남음';
        }
      }
      else {
        freeRemainingDays = '${diffTime.inHours}시간 ${diffTime.inMinutes - (diffTime.inHours * 60)}분 남음';
      }
    }

    return DefaultScaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Text(freeRemainingDays),
                ElevatedButton(
                  onPressed: () {
                    String dateStr = "2024.07.14";
                    // 정규식에서 \D를 사용하려면 \\D로 작성
                    // RegExp('\\D') 정규식을 사용하여 모든 비숫자 문자를 제거
                    dynamic dateReplaceAll = DateTime.parse(dateStr.replaceAll(RegExp('\\D'), ""));
                    // r은 Dart에서 raw 문자열을 의미
                    // raw 문자열을 사용하면 백슬래시를 이스케이프할 필요가 없음
                    dynamic dateReplaceAll2 = DateTime.parse(dateStr.replaceAll(RegExp(r'\D'), ""));

                    snackBarView(
                      context: context,
                      message: '$dateStr\n'
                      'dateReplaceAll: $dateReplaceAll\n'
                      'dateReplaceAll2: $dateReplaceAll2\n'
                    );
                  },
                  // 문자열에 \ 문자를 포함하려면 이스케이프 문자('\\')
                  child: const Text('(\\\\D), (r\\D)')
                ),
                ElevatedButton(
                  onPressed: () {
                    DateTime date2 = today.subtract(const Duration(days: 10));
                    int result1 = today.compareTo(date2);
                    int result2 = date2.compareTo(today);
                    // 앞일자면 -1을 뒤일자면 1을 반환한다. 같은날짜이면 0을 반환한다.
                    // 참고 사이트 https://in-coding.tistory.com/74
                    // result1 결과 값 1
                    // result2 결과 값 -1
                    snackBarView(
                      context: context,
                      message: 'result1: $result1\nresult2: $result2'
                    );
                  },
                  child: const Text('날짜 비교(compareTo)')
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    Duration diff = today.difference(DateTime.parse('2023-06-30'));
                    Duration diff2 = DateTime.parse('2023-06-30').difference(today);
                    // diff ${diff.inDays} 2024-01-17 기준 201
                    // diff2 ${diff2.inDays} 2024-01-17 기준 -201
                    // diff3 ${diff2.inMinutes} 2024-01-17 기준 -290848
                    DateTime yesterday = today.subtract(const Duration(days: 1));
                    Duration diff4 = yesterday.difference(today);

                    snackBarView(
                      context: context,
                      message: 'diff ${diff.inDays}\n'
                      'diff2 ${diff2.inDays}\n'
                      'inDays ${DateTime.parse('2023-11-27').difference(DateTime.parse('2023-11-30')).inDays}\n'
                      'diff3 ${diff2.inMinutes}\n'
                      'diff4 $diff4'
                    );
                    // 참고 사이트
                    // https://nsinc.tistory.com/224
                    // https://accompani-i.tistory.com/321
                  },
                  child: const Text('Duration')
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    // 월 가져오기
                    dynamic month = today.month;

                    // 일 가져오기
                    dynamic day = today.day;

                    // 요일 가져오기
                    initializeDateFormatting();
                    dynamic yoIl = DateFormat('EEEE', 'ko_KR').format(today);

                    // 어제 날짜 구하는법
                    DateTime yesterday = today.subtract(const Duration(days: 1));

                    // 날짜 빼고 더하는 법
                    DateTime dayM = DateTime(today.year, today.month, today.day-1);
                    DateTime dayP = DateTime(today.year, today.month, today.day+1);

                    // 날짜 형식을 변환
                    String dateTimeFormat({String format = 'yyyy.MM.dd', required String dateTime}) {
                      return DateFormat(format).format(DateTime.parse(dateTime)).toString();
                    }
                    String todayMonth1 = dateTimeFormat(format: 'yyyy.MM', dateTime: today.toString());
                    String todayMonth2 = dateTimeFormat(format: 'yyyy-MM', dateTime: today.toString());
                    // 예시) 1 yyyy.MM  2 yyyy-MM 3  yyyy.MM.dd

                    snackBarView(
                      context: context,
                      message: 'month $month\n'
                      'day $day\n'
                      'yoIl $yoIl\n'
                      'yesterday $yesterday\n'
                      'dayM $dayM\n'
                      'dayP $dayP\n'
                      'todayMonth1 $todayMonth1\n'
                      'todayMonth2 $todayMonth2\n'
                    );

                    // 참고 사이트
                    // https://cyj893.github.io/flutter/Flutter4
                    // https://stackoverflow.com/questions/61682959/the-date-of-yesterday-in-flutter
                  },
                  child: const Text('날짜 관련 코드')
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    List<dynamic> mondayToSunday = [];
                    // 월요일 부터 일요일 까지 날짜 가져 오기
                    for(int i=0; i<7; i++) {
                      DateTime date = today.subtract(Duration(days: today.weekday -1 -i));
                      mondayToSunday.add(DateFormat('yyyy-MM-dd').format(date));
                    }
                    snackBarView(
                      context: context,
                      message: 'mondayToSunday $mondayToSunday\n'
                    );
                  },
                  child: const Text('월요일 부터 일요일 까지')
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    // weekday > 1~7의 해당 날짜 요일의 날짜 값을 가져올 수 있다.(1 == 월, ~ 7 == 일 )
                    DateTime monDay = today.subtract(Duration(days: today.weekday - 1));
                    DateTime sunDay = today.subtract(Duration(days: today.weekday - 7));

                    // 첫날, 마지막 날 값 가져오기
                    String firstDay = DateFormat('yy.MM.dd').format(DateTime(today.year, today.month, 1));
                    // 다음 달 0일로 설정 하면 이번 달의 마지막 날 값을 가쟈온다.
                    String lastDay = DateFormat('yy.MM.dd').format(DateTime(today.year, today.month + 1, 0));
                    String lastDayDay = DateFormat('dd').format(DateTime(today.year, today.month + 1, 0));

                    // 참고 사이트
                    // https://cyj893.github.io/flutter/Flutter4_2

                    // 오늘부터 이전 달의 31개의 날짜 데이터 가져오기
                    List<dynamic> selectedMonthInfo = [];

                    String zeroMonth = '${today.month}';
                    String dayText;
                    if(today.month < 10) {
                      zeroMonth = '0${today.month}';
                    }

                    DateTime previousDate = DateTime(today.year, today.month).subtract(const Duration(days: 1));
                    int previousYear =  previousDate.year;
                    int previousMonth =  previousDate.month;
                    String previousMonthText = '$previousMonth';
                    if(previousMonth < 10) {
                      previousMonthText = '0$previousMonth';
                    }
                    String previousDayText;

                    var previousLastDay = DateFormat('dd').format(DateTime(today.year, int.parse(previousMonthText) + 1, 0));

                    int forStartDay = previousDate.day - (31 -today.day);

                    for (int i=forStartDay; i<=int.parse(previousLastDay); i++) {
                      previousDayText = '$i';
                      if(i < 10) {
                        previousDayText = '0$i';
                      }
                      selectedMonthInfo.add('$previousYear.$previousMonthText.$previousDayText');
                    }

                    for (int i=1; i<=today.day; i++) {
                      dayText = '$i';
                      if(i < 10) {
                        dayText = '0$i';
                      }
                      selectedMonthInfo.add('${today.year}.$zeroMonth.$dayText');
                    }

                    snackBarView(
                      context: context,
                      message: 'monDay $monDay\n'
                      'sunDay $sunDay\n'
                      'firstDay $firstDay\n'
                      'lastDay $lastDay\n'
                      'lastDayDay $lastDayDay\n'
                      'forStartDay $forStartDay\n'
                      'selectedMonthInfo $selectedMonthInfo\n'
                    );
                  },
                  child: const Text('날짜 관련 코드2')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

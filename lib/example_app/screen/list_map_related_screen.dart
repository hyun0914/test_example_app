import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';
import 'widget/snack_bar_view.dart';

class ListMapRelatedScreen extends StatelessWidget {
  const ListMapRelatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // 참고 사이트
                // https://dev-dain.tistory.com/137
                // 특정 값의 인덱스 찾기
                // https://www.everdevel.com/Dart/list-indexOf
                List<dynamic> list = ['1', 1,];

                // List 이어 붙히기
                // https://velog.io/@tmdgks2222/FlutterDart-List-aljalddakkalsen
                List<dynamic> list1 = [1, 2, 3];
                List<dynamic> list2 = [0, ...list1];

                // 2개의 List 비교
                // https://velog.io/@adbr/dart-compare-two-lists
                List<String> test1 = ['1', '2', '3'];
                List<String> test2 = ['1', '2', '3'];

                snackBarView(
                  context: context,
                  message: 'list $list\n'
                  'isEmpty ${list.isEmpty}\n'
                  'isNotEmpty ${list.isNotEmpty}\n'
                  'length ${list.length}\n'
                  'reversed ${list.reversed}\n'
                  'sort ${list.sort}\n'
                  'contains ${list.contains(1)}\n'
                  'indexOf ${list.indexOf(1)}\n'
                  'List 이어 붙히기 list1 $list1\n'
                  'List 이어 붙히기 list2 $list2\n'
                  '2개의 List 비교 ${listEquals(test1, test2)}\n'
                );
              },
              child: const Text('List')
            ),
            ElevatedButton(
              onPressed: () {
                // 참고 사이트
                // https://dev-dain.tistory.com/138

                Map<String, dynamic> map = {
                  '1': 1,
                  '2': '2',
                };
                map.addAll({'3': 3});
                // map.clear();
                // map.remove('1');

                // Map에 List를 value로 선언 후 list 값 넣는 법
                Map<int, List<bool>> map1 = {};
                List<bool> map2 = [];

                for(int i=0; i<3; i++) {
                  map1.addAll({i: []});
                  map2 = [];
                  for(int j=0; j<3; j++) {
                    map2.add(false);
                  }
                  map1[i] = map2;
                }

                // List<Map> 정렬
                // https://stackoverflow.com/questions/22177838/sort-a-list-of-maps-in-dart-second-level-sort-in-dart
                // https://codechacha.com/ko/dart-sort-map-entries/
                List<Map<String, dynamic>> listMap = [];
                listMap.add({'test': '1', 'a': 33,});
                listMap.add({'test': '2', 'a': 99,});
                listMap.add({'test': '3', 'a': 44,});

                listMap.sort((a, b) => (b['a'].compareTo(a['a'])));

                Map<int, String> map4 = {5: 'a', 1: 'k', 3: 'm', 4: 'o'};

                Map<int, String> sortedMap = Map.fromEntries(
                  map4.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key))
                );

                Map<int, String> sortedMap2 = Map.fromEntries(
                  map4.entries.toList()..sort((e1, e2) => e2.key.compareTo(e1.key))
                );

                // 리스트를 맵으로 하여 위치를 고정으로 한후 value 값만 추출하기
                Map<int, List<Map<String, dynamic>>> test = {};

                List<Map<String, dynamic>> test2 = [];

                for(int i=0; i<5; i++) {
                 test.addAll({i: []});
                }

                print('test $test');

                for(int j=0; j<5; j++){
                  test2.add({
                    'a': j,
                    'b': 2,
                    'c': 'test',
                  });
                }
                print('[test2[0]] ${[test2[0]]}');

                test[0] = [test2[0]];

                print('test $test');

                // 선언
                List<Map<String, dynamic>> testList1 = [];
                Map<int, List<Map<String, dynamic>>> testList2 = {};

                for (int i = 0; i < 4; i++) {
                  testList2.addAll({i: [{'a': i, 'b': '', 'c': ''}]});
                }

                print('testList2 $testList2');

                print('testList2.values ${testList2.values}');

                print('testList2.values.toList()[0][0] ${testList2.values.toList()[0][0]}');

                for(int i =0; i < testList2.length; i++) {
                  testList1.add(testList2.values.toList()[i][0]);
                }

                print('testList1 $testList1');

                // 값 넣기
                testList2[0]![0]['a'] = 1;

                // map의 value length 값 구하는 법

                Map<String, List<String>> map3 = {
                 'test': ['1', '2', '3', '4'],
                };

                snackBarView(
                  context: context,
                  message: 'map $map\n'
                  'keys ${map.keys}\n'
                  'values ${map.values}\n'
                  'entries ${map.entries}\n'
                  'isEmpty ${map.isEmpty}\n'
                  'isNotEmpty ${map.isNotEmpty}\n'
                  'length ${map.length}\n'
                  'containsKey ${map.containsKey('1')}\n'
                  // map: '1' key 가 있는지 파악 true, false 로 return 값이 온다.
                  'containsValue ${map.containsValue(1)}\n'
                  // map: 1 value 가 있는지 파악 true, false 로 return 값이 온다.
                  'map1 $map1\n'
                  'listMap $listMap\n'
                  'map3의 value length ${map3['test']!.toList().length}\n'
                  'map4 sort 오름차순 $sortedMap}\n'
                  'map4 sort 내림차순 $sortedMap2}\n'
                );
              },
              child: const Text('Map')
            ),
          ],
        ),
      ),
    );
  }
}

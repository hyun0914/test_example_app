import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget/default_scaffold.dart';
import 'widget/snack_bar_view.dart';

class InternalStorageScreen extends StatelessWidget {
  const InternalStorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs;
    return DefaultScaffold(
      body: Center(
        child: Column(
          children: [
            // 참고 사이트
            // https://flutter-ko.dev/cookbook/persistence/key-value
            // https://sothecode.tistory.com/19
            ElevatedButton(
              onPressed: () async {
                prefs = await SharedPreferences.getInstance();
                await prefs.setInt('number', 4444);
                await prefs.setDouble('decimal_point', 4.4);
                await prefs.setBool('true_false', false);
                await prefs.setString('str', 'String save');
                await prefs.setStringList('mog_log', ['Android', 'iOS', 'Web']);
              },
              child: const Text('shared_preferences 저장')
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () async {
                prefs = await SharedPreferences.getInstance();
                final int? number = prefs.getInt('number');
                final double? decimalPoint = prefs.getDouble('decimal_point');
                final bool? trueFalse = prefs.getBool('true_false');
                final String? str = prefs.getString('str');
                final List? mogLog = prefs.getStringList('mog_log');
                snackBarView(
                  context:context,
                  message:'$number\n'
                  '$decimalPoint\n'
                  '$trueFalse\n'
                  '$str\n'
                  '$mogLog\n'
                );
              },
              child: const Text('shared_preferences 읽기')
            ),
          ],
        ),
      ),
    );
  }
}

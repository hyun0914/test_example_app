import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import 'widget/default_scaffold.dart';

class MailerPackagesScreen extends StatelessWidget {
  const MailerPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 최대값10000, 최소값1000
    // 최대값만 지정하니 1000이하 숫자도 생성되어서 1000이하 숫자 생성 방지
    // 참고 사이트 https://hymndev.tistory.com/m/40
    final rand = Random().nextInt(10000-1000)+1000;

    // 참고 사이트
    // https://www.youtube.com/watch?v=PQ07DUW8o6k
    // https://eunjin3786.tistory.com/m/332

    mailCheck() async {
      String username = 'test@gmail.com';
      String password = '비밀번호';

      final smtpServer = gmail(username, password);

      final message = Message()
        ..from = Address(username, '${username}')
        ..recipients.add('test@gmail.com')
        ..ccRecipients.add('id')
        ..subject = "인증 번호"
        ..html = "<p>${rand}</p>";

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: $sendReport');
      }
      on MailerException catch (e) {
        print('Message not sent.');
        print(e.message);
      }
    }

    return DefaultScaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // mailCheck();
              },
              child: const Text('메일 보내기')
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../main_page.dart';
import '../../layout/simple_bar_layout.dart';
import 'change_password_page.dart';
import 'profile_edit_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String getId = '';

  @override
  Widget build(BuildContext context) {
    return SimpleBarLayout(
      title: '설정',
      topIcon: null,
      children: [
        Expanded(
            child: ListView(
            children: [
              Column(
                children: [
                  ListTile(
                    title: const Text('프로필 변경'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileEditPage()),
                      );
                    },
                    enabled: getId == 'null'? false : true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Container(
                      color: Colors.grey[300],
                      height: 3,
                    ),
                  ),
                  ListTile(
                    title: const Text('비밀번호 변경'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
                      );
                    },
                    enabled: getId == 'null'? false : true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Container(
                      color: Colors.grey[300],
                      height: 3,
                    ),
                  ),
                  ListTile(
                    title: const Text('이용약관'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Container(
                      color: Colors.grey[300],
                      height: 3,
                    ),
                  ),
                  getId == 'null'?
                  const SizedBox():
                  ListTile(
                    title: const Text('로그아웃'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MainPage()),  (route) => false);
                    },
                  ),
                  getId == 'null'?
                  const SizedBox():
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Container(
                      color: Colors.grey[300],
                      height: 3,
                    ),
                  ),
                  const ListTile(
                    title: Text('앱 버전'),
                    trailing: Text('1.0.0'),
                  ),
                ],
              )
            ],
          )
        )
      ],
    );
  }
}

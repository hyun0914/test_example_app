import 'package:flutter/material.dart';

import '../layout/simple_bar_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool obscureText = true;

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleBarLayout(
      title: '로그인',
      topIcon: null,
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 9,),
                Image.asset('assets/images/hen.png', width: 150, height: 200,),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: idController,
                    onChanged: (email) {},
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: '이메일', helperText: '', border: OutlineInputBorder()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                  child: TextField(
                    controller: pwController,
                    onChanged: (password) {},
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      labelText: '비밀번호', helperText: '', border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if(obscureText) {
                              obscureText = false;
                            } else {
                              obscureText = true;
                            }
                          });
                        },
                        icon: obscureText == true? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                      )
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Colors.greenAccent
                    ),
                    onPressed: () {},
                    child: const Text('로그인', style: TextStyle(fontSize: 17, color: Colors.indigoAccent)),
                  ),
                ),
                const SizedBox(height: 14,),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '이메일로 간단하게 회원가입하기',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

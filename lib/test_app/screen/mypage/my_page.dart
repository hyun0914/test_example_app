import 'package:flutter/material.dart';
import 'login_page.dart';
import 'setting/setting_page.dart';

String loginCheck = 'false'; //false true

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Column(
                      children: [
                        loginCheck == 'false'?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 25,),
                              child: const ClipOval(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.account_circle_sharp,
                                    size: 70,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginPage()),
                                  );
                                },
                                style: ButtonStyle(
                                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                                      if (states.contains(WidgetState.pressed)) {
                                        return Colors.grey;
                                      }
                                      return Colors.black;
                                    }
                                  ),
                                ),
                                child: const Column(
                                  children: [
                                    Text(
                                      '로그인 & 회원가입',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Text(
                                      '로그인 하고 서비스를',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(height: 3,),
                                    Text(
                                      '자유롭게 이용해보세요',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ]
                                )
                              ),
                            ),
                          ],
                        )
                        : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            ClipOval(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.asset(
                                'assets/images/chicken.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              const Text('닉네임', style: TextStyle(fontSize: 20,),),
                              const SizedBox(height: 12,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    const Text(
                                      '팔로워  4444',
                                      style: TextStyle(fontSize: 14,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                      ),
                                      child: Container(
                                        width: 1,
                                        height: 10,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    const Text(
                                      '팔로잉  4444',
                                      style: TextStyle(fontSize: 14,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14,),
                  listTileForm('문의내역', null,),
                  listTileForm('나의 리뷰', null,),
                  listTileForm('고객센터', null,),
                  listTileForm('설정', (){Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingPage()));},),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget listTileForm(String ltText, VoidCallback? callback){
  return Column(
    children: [
      ListTile(
        title: Text(ltText),
        trailing: const Icon(Icons.navigate_next),
        onTap: callback,
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
    ],
  );
}

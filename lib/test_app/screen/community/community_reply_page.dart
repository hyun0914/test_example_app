import 'package:flutter/material.dart';

import '../layout/simple_bar_layout.dart';

class CommunityReplyPage extends StatefulWidget {
  const CommunityReplyPage({super.key});

  @override
  State<CommunityReplyPage> createState() => _CommunityReplyPageState();
}

class _CommunityReplyPageState extends State<CommunityReplyPage> {
  final _replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleBarLayout(
      title: '댓글',
      topIcon: null,
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 16,
            itemBuilder:(context, index) {
              return Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 14),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(child: Image.asset('assets/images/pizza.png', fit: BoxFit.fill, width: 40, height: 40,)),
                          const SizedBox(width: 10,),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('닉네임'),
                                  SizedBox(width: 8,),
                                  Text('날짜', style: TextStyle(fontSize: 12),),
                                ],
                              ),
                              SizedBox(height: 4,),
                              Text('내용'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
            }
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14, right: 14, bottom: 35),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: _replyController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '댓글을 입력해주세요',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(14)
                      )
                    ),
                    onPressed: () {},
                    child: const Text('등록', style: TextStyle(fontSize: 17, color: Colors.white),)
                  )
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }
}

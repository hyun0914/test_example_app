import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../banner/banner_page.dart';
import 'community_details.dart';


class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

// web에서 Horizontal scrolling 사용하기 위해 생성한 class
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class _CommunityPageState extends State<CommunityPage> {
  bool click = false;
  int childCount = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                 child: Column(
                   children: [
                     Container(
                       color: Colors.grey[300],
                       height: 2,
                     ),
                     // Top 10
                     Container(
                       padding: const EdgeInsets.only(top: 8, bottom: 8),
                       child: SizedBox(height: 180, child: highRankImg(context)),
                     ),
                     Container(
                       color: Colors.grey[300],
                       height: 8,
                     ),
                     Container(
                       padding: const EdgeInsets.all(8.0),
                       child: const SizedBox(
                         height: 200,
                         child: BannerPage(imgList: [
                           'assets/images/sale.png',
                           'assets/images/screen.png',
                           'assets/images/email_img.png',
                         ],),
                       ),
                     ),
                     Container(
                       color: Colors.grey[300],
                       height: 8,
                     ),
                   ],
                 )
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index){
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CommunityDetails()));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(13, 7, 13, 7),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset('assets/images/chicken.jpg'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(13, 0, 13, 7),
                              child: Column(
                                children: [
                                  Text(
                                    '글제목 $index',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ClipOval(child: Image.asset('assets/images/hen.png', fit: BoxFit.fill, width: 15, height: 15,)),
                                          const SizedBox(width: 5,),
                                          const Text('닉네임', style: TextStyle(fontSize: 12),),
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Icon(Icons.favorite, size: 14,),
                                          Text('0', style: TextStyle(fontSize: 12),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount : childCount,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 80),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              childCount = childCount +8;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            padding: const EdgeInsets.all(15),
                            child: const Center(
                              child: Text('더보기'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ) ,
          ),
        ),
      ],
    );
  }

  ScrollConfiguration highRankImg(BuildContext context){
    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        scrollDirection: Axis.horizontal,
        itemCount: 14,
        itemBuilder: (context, index){
          return Container(
            margin: const EdgeInsets.only(right: 10),
            child: Column(
              children: [
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  dashPattern: const [8, 4],
                  strokeWidth: 2,
                  child: SizedBox(
                    width: 180,
                    height: 140,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CommunityDetails())),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(3.0),
                        child: Image.asset('assets/images/pizza.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                const Text('글 제목 영역')
              ],
            ),
          );
        }
      ),
    );
  }
}
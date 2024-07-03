import 'package:flutter/material.dart';
import '../main_page.dart';
import '../layout/simple_bar_layout.dart';
import 'community_edit_page.dart';
import 'community_reply_page.dart';
import 'image_details.dart';

class CommunityDetails extends StatefulWidget {

  const CommunityDetails({super.key});

  @override
  State<CommunityDetails> createState() => _CommunityDetailsState();
}

class _CommunityDetailsState extends State<CommunityDetails> {
  bool likeClick = false;

  @override
  Widget build(BuildContext context) {
    return SimpleBarLayout(
      title: '',
      topIcon: [
        IconButton(
          onPressed: (){
              showModalBottomSheet(context: context, builder: (_) {
                return SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade300,
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const InkWell(
                                child: Row(
                                  children: [
                                    Icon(Icons.bookmark),
                                    SizedBox(width: 4,),
                                    Text('해당 북마크 생성', style: TextStyle(fontSize: 17),),
                                  ],
                                )
                              ),
                              const SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: InkWell(
                                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CommunityEditPage())),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(width: 4,),
                                      Text('수정', style: TextStyle(fontSize: 17),),
                                    ],
                                  )
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: InkWell(
                                  onTap: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MainPage()), (route) => false),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.delete),
                                      SizedBox(width: 4,),
                                      Text('삭제', style: TextStyle(fontSize: 17),),
                                    ],
                                  )
                                ),
                              ),

                              const InkWell(
                                child: Row(
                                  children: [
                                    Icon(Icons.priority_high),
                                    SizedBox(width: 4,),
                                    Text('신고', style: TextStyle(fontSize: 17),),
                                  ],
                                )
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            );
          },
          icon: const Icon(Icons.more_horiz),
        ),
      ],
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text('글제목', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipOval(child: Image.asset('assets/images/hen.png', fit: BoxFit.fill, width: 20, height: 20,)),
                              const SizedBox(width: 4,),
                              const Text('닉네임', style: TextStyle(fontSize: 14),),
                              const SizedBox(width: 4,),
                              const Text('날짜', style: TextStyle(fontSize: 12),)
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,)
                  ],
                ),
              ),
              subImageSliverList(context),
              const SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, left: 12),
                            child: Text('글 내용'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    if(likeClick == false){
                      likeClick = true;
                    }
                    else if(likeClick == true){
                      likeClick = false;
                    }
                  });
                },
                child: Row(
                  children: [
                    likeClick == false? const Icon(Icons.favorite_border) : const Icon(Icons.favorite, color: Colors.red,),
                    const SizedBox(width: 4,),
                    const Text('좋아요')
                  ],
                ),
              ),

              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CommunityReplyPage())),
                child: const Row(
                  children: [
                    Icon(Icons.chat_bubble_outline),
                    SizedBox(width: 4,),
                    Text('댓글달기')
                  ],
                ),
              ),

              InkWell(
                onTap: (){},
                child: const Row(
                  children: [
                    Icon(Icons.send),
                    SizedBox(width: 4,),
                    Text('공유하기')
                  ],
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }
}

SliverList subImageSliverList(BuildContext context){
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index){
        return GestureDetector(
          onTap: (){
            if(index == index) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ImageDetails()));
            }
          },
          child: Image.asset('assets/images/pizza.png')
        );
      },
      childCount:  2,
    ),
  );
}

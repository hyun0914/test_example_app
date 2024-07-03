import 'package:flutter/material.dart';

import '../layout/simple_bar_layout.dart';
import 'search_next_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleBarLayout(
      title: '검색창',
      topIcon: null,
      children: [
          SizedBox(
            height: 50,
            child: TextFormField(
              controller: contentController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: '검색어를 입력해주세요',
              ),
              onFieldSubmitted: (_){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchNextPage(getTest: contentController.text,)));
                print('Testgo');
              },
            ),
          ),
          const SizedBox(height: 5,),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: [
                Text('최근 검색어'),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, int index) {
              return ListTile(
                title: const Text('검색어'),
                trailing: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.close),
                ),
              );
            },
          )
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';

// 참고 사이트
// https://devlopsquare.tistory.com/85
// https://velog.io/@cyb9701/Flutter-OverlayEntry%EB%A1%9C-Dropdown-%EC%A7%81%EC%A0%91-%EB%A7%8C%EB%93%A4%EA%B8%B0
// https://blog.logrocket.com/creating-dropdown-list-flutter

// inputDecoration 참고사이트 (DropdownButton inputDecoration)
// https://stackoverflow.com/questions/64004891/how-to-add-decoration-dropdownbutton-in-flutter

// menuItem을 하단에 패치할려면 패키지 사용해야한다.
//

class DropDownBut extends StatefulWidget {
  const DropDownBut({super.key});

  @override
  State<DropDownBut> createState() => _DropDownButState();
}

class _DropDownButState extends State<DropDownBut> {
  final List<String> testListItems = ['테스트1', '테스트2', '테스트3', '테스트4',  '테스트5'];
  var testListSelected = '테스트1';

  final List<String> dropdownList = ['테스트항목0', '테스트항목1', '테스트항목2', '테스트항목4'];

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          width: 350,
          height: 50,
          padding: const EdgeInsets.only(left: 10),
          child: DropdownButton(
            value: testListSelected,
            items: testListItems.map(
              (value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value)
                );
              }
            ).toList(),
            onChanged: (value) {
              setState(() {
                testListSelected = value as String;
              });
            },
          ),
        ),

        DropdownButtonFormField(
          style: const TextStyle(fontSize: 16, color: Colors.black),
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))
            )
          ),
          hint: const Text('항목을 선택해주세요'),
          items: dropdownList.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {},
        ),
      ],
    );
  }
}

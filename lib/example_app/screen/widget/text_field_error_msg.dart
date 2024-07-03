import 'package:flutter/material.dart';

class TextFieldErrorMsg extends StatefulWidget {
  const TextFieldErrorMsg({super.key});

  @override
  State<TextFieldErrorMsg> createState() => _TextFieldErrorMsgState();
}

class _TextFieldErrorMsgState extends State<TextFieldErrorMsg> {
  final idController = TextEditingController();
  bool isButtonEnabled = false;
  String? errorText;
  bool autofocus = false;

  @override
  void initState() {
    super.initState();
    idController.addListener((){
      final isNotEmpty = idController.text.isNotEmpty;
      if(isButtonEnabled != isNotEmpty) {
        setState(() {
          isButtonEnabled = isNotEmpty;
          errorText = isButtonEnabled ? null : '아이디를 입력해 주세요..';
          autofocus = true;
        });
      }
    });
  }

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          TextField(
            autofocus: autofocus,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              errorText: errorText,
              hintText: '아이디를 입력해 주세요.',
            ),
            controller: idController,
            onChanged: (String value) {},
          ),

          ElevatedButton(
            onPressed: isButtonEnabled ? (){} : null,
            child: const Text('다음'),
          ),
        ],
      ),
    );
  }
}

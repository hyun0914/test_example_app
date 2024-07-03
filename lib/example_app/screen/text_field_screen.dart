import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'widget/default_scaffold.dart';
import 'widget/text_field_error_msg.dart';

class TextFieldScreen extends StatelessWidget {
  const TextFieldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    FocusNode emailFocus =  FocusNode();
    FocusNode searchFocus = FocusNode();
    ScrollController scrollController = ScrollController();
    // 다른 영역 클릭 시 키보드 비활성화 하는 패키지
    return KeyboardDismissOnTap(
      child: DefaultScaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            // 키보드 활성화 상태에서 스크롤 시 키보드 비활성화로 변경
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                // 참고 사이트
                // https://annhee.tistory.com/72
                // https://velog.io/@adbr/FocusScope
                // https://lucky516.tistory.com/111
                // https://dev-nam.tistory.com/26
                GestureDetector(
                  onTap: () { searchFocus.unfocus(); },
                  child: const Text('포커스 해제', style: TextStyle(fontSize: 20),)
                ),
                GestureDetector(
                  onTap: () { FocusScope.of(context).unfocus(); },
                  child: const Text('포커스 해제2', style: TextStyle(fontSize: 20),)
                ),
                // 참고 사이트
                // https://papabee.tistory.com/113
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextFormField(
                    decoration: decoration,
                    // 엔터 이벤트
                    onFieldSubmitted: (value) {
                      print('onFieldSubmitted: 엔터 누름');
                      print(value);
                    },
                    // 키보드로 입력 할때마다 발생하는 이벤트
                    onChanged: (value) {
                      print(value);
                    },
                    focusNode: searchFocus,
                    // 텍스트필드 최대입력값 설정 및 텍스트 위치 조정
                    // 참고 사이트
                    // https://develop-designer.tistory.com/45
                    // maxLength 숫자표시값을 위치를 TextField의 오른쪽에 표시하는법(기본세팅이 젤오른쪽 TextField아래에 표시)
                    // https://childcare-daddy.tistory.com/15
                    // https://blog.naver.com/chandong83/222010129921
                    maxLength: 10,
                    textAlign: TextAlign.right,
                    // 다음 텍스트필드로 이동
                    // 참고 사이트
                    // https://velog.io/@locked/Flutter-%EB%8B%A4%EC%9D%8C-TextField%EC%97%90-Focus%ED%95%98%EA%B8%B0
                    // https://develop-designer.tistory.com/43
                    // TextInputAction.done, - 완료 추가
                    textInputAction: TextInputAction.next,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    decoration: decoration,
                    onSubmitted: (value) {
                      print('onSubmitted: 엔터 누름');
                      print(value);
                    },
                    // 한글만 입력되게 하는 법
                    // 이 방법으로 특정 문자 입력 방지 가능 (flutter textfield emoticon no)
                    // 참고 사이트
                    // https://velog.io/@jungti1234/Flutter-TextField-%ED%95%9C%EA%B8%80%EB%A7%8C-%ED%97%88%EC%9A%A9%ED%95%98%EA%B8%B0-%EC%B2%9C%EC%A7%80%EC%9D%B810%ED%82%A4-%EC%A1%B0%ED%95%A9%ED%98%95-%EB%AC%B8%EC%A0%9C-%ED%95%B4%EA%B2%B0-%ED%8F%AC%ED%95%A8
                    // https://stackoverflow.com/questions/58263801/how-to-restrict-emoji-for-textfield-in-flutter
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ]')),],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    decoration: decoration,
                    maxLines: 5,
                    // none 으로 선택해도 엔터가 되지만 ios에서 에러발생 none > unspecified 로 변경
                    textInputAction: TextInputAction.unspecified,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Form(
                    key: formKey2,
                    child: Column(
                      children: [
                        // 참고 사이트
                        // https://blog.codefactory.ai/flutter/form
                        // https://gloria94.tistory.com/22

                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          focusNode: emailFocus,
                          controller: emailController,
                          validator: (value) {
                            if(value!.isEmpty){
                              emailFocus.requestFocus();
                              return '이메일 형식으로 작성해주세요';
                            }
                            else {
                              // 이메일 형식체크
                              Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp reqExp = RegExp(pattern.toString());
                              if(!reqExp.hasMatch(value)){
                                emailFocus.requestFocus();
                                return '이메일 형식으로 작성해주세요';
                              }
                              else{
                                return null;
                              }
                            }
                          },
                          onSaved: (value) {},
                          decoration: const InputDecoration(
                            labelText: '이메일',
                            helperText: '이메일을 입력해주세요.',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            formKey2.currentState!.validate();
                          },
                          child: const Text('이메일 형식 체크'),
                        )
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextFormField(
                    maxLength: 10,
                    decoration: const InputDecoration(
                      // maxLength 설정시 오른쪽 하단 부분 0/10 텍스트 사라진다.
                      counterText: '',
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: const TextField(
                    decoration: InputDecoration(
                      // TextField 밑줄 제거
                      // https://otrodevym.tistory.com/entry/Flutter-TextField%EC%9D%98-Underline-%EC%A0%9C%EA%B1%B0%ED%95%98%EB%8A%94-%EB%B0%A9%EB%B2%95
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    // 숫자만 입력되게 하기
                    // 참고 사이트
                    // https://velog.io/@ssorry_choi/Dart-Textfield-%EC%A0%95%EA%B7%9C%EC%8B%9D
                    // 숫자 키보드
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                // TextField 멀티 텍스트 필드로 표시하기
                // 참고 사이트
                // https://www.flutterbeads.com/multiline-textfield-in-flutter/
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: const TextField(
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  // TextField에 스크롤바 추가
                  // https://stackoverflow.com/questions/67475181/flutter-scrollbar-on-textfield
                  child: Scrollbar(
                    controller: scrollController,
                    child: const TextField(
                      minLines: 5,
                      maxLines: 5,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    // 특정 문자 입력하지 못하게 하는 방법
                    // TextField에 @ 입력하지 못한다.
                    // 참고 사이트
                    // https://velog.io/@adbr/flutter-TextFormField-%ED%8A%B9%EC%A0%95-%EB%AC%B8%EC%9E%90-%EC%A0%9C%ED%95%9C-Restrict-Special-Character-Input-Flutter
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[\\@]')),
                    ],
                    // border 하단만 적용
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder()
                    )
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: const TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.amberAccent,
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none)
                    )
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      hintText: 'hintText',
                      helperText: 'helperText',
                      labelText: 'labelText',
                      counterText: 'counterText',
                      // counter 가 적용하면 counterText, counterStyle 무시됨
                      // counter: Text('counter')
                    ),
                  ),
                ),
                // 참고 사이트
                // https://dalgoodori.tistory.com/60
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      CurrencyTextInputFormatter.currency(
                        locale: 'ko',
                        decimalDigits: 0,
                        symbol: 'KRW(원)',
                      )
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    cursorColor: Colors.deepPurpleAccent,
                    cursorWidth: 3,
                    // 커서 노출 여부
                    // showCursor: true,
                    decoration: const InputDecoration(
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2,
                          // https://stackoverflow.com/questions/75323117/flutter-error-the-getter-strokealign-isnt-defined-for-the-class
                          strokeAlign: BorderSide.strokeAlignOutside,
                        )
                      ),
                      errorStyle: TextStyle(),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        )
                      )
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '1자 이상 입력하세요.';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final formKeyState = formKey.currentState!;
                    if (formKeyState.validate()) {
                      formKeyState.save();
                    }
                  },
                  child: const Text('확인'),
                ),

                const TextFieldErrorMsg(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// border 기본 border스타일 정의
// enabledBorder enabled가 true일때 border스타일 정의
// disabledBorder enabled가 false일때 border스타일 정의
// focusedBorder 텍스트필드 클릭시 border스타일 정의
// errorBorder error 텍스트 표시일때 border스타일 정의

InputDecoration decoration = const InputDecoration(
  // 아이콘 추가
  // 참고 사이트
  // https://stackoverflow.com/questions/69834456/how-to-add-search-icon-to-textfield-in-flutter
  prefixIcon: Icon(Icons.search),
  suffixIcon: Icon(Icons.dashboard),
  // TextField 색상 주기
  // 참고 사이트 https://kibua20.tistory.com/237
  filled: true,
  fillColor: Color.fromRGBO(110, 220, 220, 1),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(50.0),),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(50.0),),
  ),
);
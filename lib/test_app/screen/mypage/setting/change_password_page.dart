import 'package:flutter/material.dart';

import '../../layout/simple_bar_layout.dart';
import '../../main_page.dart';


class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleBarLayout(
      title: '비밀번호 변경',
      topIcon: null,
      children: [
        PasswordInput(),
      ],
    );
  }
}

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  TextEditingController pwController = TextEditingController();

  bool checkPa = false;

  final forKey = GlobalKey<FormState>();

  void tryValidation(){
    final isValid = forKey.currentState!.validate();
    if(isValid){
      forKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Column(
        children: [
          Form(
            key: forKey,
            child: TextFormField(
              controller: pwController,
              onChanged: (password) {},
              obscureText: true,
              validator: (value){
                Pattern pattern = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,16}$';
                RegExp reqExp = RegExp(pattern.toString());
                if(!reqExp.hasMatch(value!)){
                  return '특수문자, 숫자 포함 8자이상 16자 이내로 입력해주세요';
                }
                else{
                  checkPa = true;
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: '새 비밀번호',
                helperText: '',
              ),
            ),
          ),
          const SizedBox(height: 14,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.05,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              onPressed: () {
                if(pwController.text !=''){
                  if(checkPa == false){
                    tryValidation();
                  }
                  else if(checkPa == true){
                    toastView('비밀번호 변경 완료');
                    Navigator.pop(context);
                  }
                }
                else{
                  tryValidation();
                  toastView('변경할 비밀번호를 작성 해주세요.');
                }
              },
              child: const Text('비밀번호 변경', style: TextStyle(fontSize: 17, color: Colors.indigoAccent),),
            ),
          ),
        ],
      ),
    );
  }
}



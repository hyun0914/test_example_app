import 'package:flutter/material.dart';

void snackBarView({
  required BuildContext context,
  required String message
}) {
  // 참고 사이트
  // https://hevton.tistory.com/888
  // Future.delayed 없이 Widget build(BuildContext context) { 아래 바로 호출 하니
  // The showSnackBar() method cannot be called during build. 에러 발생
  Future.delayed(Duration.zero, () {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
  });
}
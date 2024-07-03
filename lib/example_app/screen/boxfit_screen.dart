import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';

class BoxFitScreen extends StatelessWidget {
  const BoxFitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 참고 사이트
              // https://devmg.tistory.com/181

              const Text('원본', style: TextStyle(fontSize: 24),),
              SizedBox(
                width: 400,
                height: 200,
                child: Image.asset('assets/images/chicken.jpg'),
              ),
              const SizedBox(height: 10,),

              // fill 지정한 영역을 꽉 채운다 비율 변경됨
              const Text('BoxFit.fill', style: TextStyle(fontSize: 24),),
              SizedBox(
                width: 400,
                height: 200,
                child: Image.asset('assets/images/chicken.jpg', fit: BoxFit.fill,),
              ),
              const SizedBox(height: 10,),

              // cover 지정한 영역을 꽉 채운다 비율유지
              const Text('BoxFit.cover', style: TextStyle(fontSize: 24),),
              SizedBox(
                width: 400,
                height: 200,
                child: Image.asset('assets/images/chicken.jpg', fit: BoxFit.cover,),
              ),
              const SizedBox(height: 10,),

              // contain 비율변화 없음
              const Text('BoxFit.contain', style: TextStyle(fontSize: 24),),
              SizedBox(
                width: 400,
                height: 200,
                child: Image.asset('assets/images/chicken.jpg', fit: BoxFit.contain,),
              ),
              const SizedBox(height: 10,),

              // fitHeight 높이에 맞게 확대 또는 축소
              const Text('BoxFit.fitHeight', style: TextStyle(fontSize: 24),),
              SizedBox(
                width: 400,
                height: 200,
                child: Image.asset('assets/images/chicken.jpg', fit: BoxFit.fitHeight,),
              ),
              const SizedBox(height: 10,),

              // fitWidth 너비에 맞게 확재 또는 축소
              const Text('BoxFit.fitHeight', style: TextStyle(fontSize: 24),),
              SizedBox(
                width: 400,
                height: 200,
                child: Image.asset('assets/images/chicken.jpg', fit: BoxFit.fitWidth,),
              ),
              const SizedBox(height: 10,),

              // none 원본유지 원본기준으로 해당영역 크기만큼 가운데 표시
              const Text('BoxFit.none', style: TextStyle(fontSize: 24),),
              SizedBox(
                width: 400,
                height: 200,
                child: Image.asset('assets/images/chicken.jpg', fit: BoxFit.none,),
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}

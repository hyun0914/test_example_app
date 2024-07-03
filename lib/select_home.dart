import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'example_app/select_test.dart';
import 'oss_licenses/oss_licenses_page.dart';
import 'test_app/screen/main_page.dart';

class SelectHome extends StatelessWidget {
  const SelectHome ({super.key});

  @override
  Widget build(BuildContext context) {
    // StatusBar(상태바(상단,하단) 숨기기
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // 참고 사이트 https://ahang.tistory.com/3
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // useMaterial3: false,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            // ios 페이지 이동 애니메이션을 안드로이드에서 적용하는 법
            // flutter cupertinopageroute
            // 참고 사이트 https://gigas-blog.tistory.com/284
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }
        )
      ),
      // 다크모드 설정
      // 참고 사이트
      // https://velog.io/@tygerhwang/Flutter-Light-Dark-%ED%85%8C%EB%A7%88-%EC%A0%81%EC%9A%A9%ED%95%B4-%EB%B3%B4%EA%B8%B0
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.dark,
      home: MediaQuery(
        // 주어진 글꼴 크기에 곱하여 들어오는 글꼴 크기를 조정하는 비례 TextScaler를textScaleFactor
        // MediaQuery.of(context).copyWith(textScaleFactor: 1.0), 에서
        // MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(0.8)), 으로 변경됨 (3.16)
        // TextScaler.linear(1.0) == TextScaler.noScaling 이다.
        // textScaleFactor
        // 참고 사이트 https://jutole.tistory.com/112?category=570267
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
        child: const SelectHomeView()
      ),
    );
  }
}

class SelectHomeView extends StatelessWidget {
  const SelectHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: ElevatedButton(
                  // 일정시간 지연 시키는 법
                  // 참고 사이트
                  // https://dkanxmstmdgml.tistory.com/153
                  onPressed: () => Future.delayed(const Duration(milliseconds: 1500)).then((value) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MainPage()));
                  }),
                  child: const Text('테스트 앱화면')
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SelectTest())),
                  child: const Text('예제 앱화면')
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OssLicensesPage())),
                  child: const Text('오픈소스 라이센스')
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}


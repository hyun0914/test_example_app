import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ios_utsname_ext/extension.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package_widget01_screen.dart';
import 'widget/default_scaffold.dart';
import 'widget/snack_bar_view.dart';

class AppsDeviceInfoScreen extends StatelessWidget {
  const AppsDeviceInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if(Platform.isAndroid) {
                    _openNotificationSettings();
                  }

                  if(Platform.isIOS) {
                    _openSettingsApp();
                  }
                },
                child: const Text('앱 설정 으로 이동')
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  // 참고 사이트
                  // https://childcare-daddy.tistory.com/5
                  // https://zeddios.tistory.com/1123
                  if(Platform.isAndroid) {
                    snackBarView(
                      context: context,
                      message: 'android'
                    );
                  }
                  else if(Platform.isIOS) {
                    snackBarView(
                      context: context,
                      message: 'IOS'
                    );
                  }
                  else if(kIsWeb) {
                    snackBarView(
                      context: context,
                      message: 'Web'
                    );
                  }
                },
                child: const Text('플랫폼(Platform) 체크')
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () => packageInfoGet().then((value) {
                  snackBarView(
                    context: context,
                    message: '$value'
                  );
                }),
                child: const Text('package_info_plus  테스트')
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () => iosInfo().then((value) {
                  snackBarView(
                    context: context,
                    message: '$value'
                  );
                }),
                child: const Text('ios_utsname_ext  테스트')
              ),
              ElevatedButton(
                onPressed: () => batteryState(context: context),
                child: const Text('battery_plus  테스트')
              ),
              ElevatedButton(
                onPressed: () {
                  // 참고 사이트
                  // https://m.blog.naver.com/chandong83/221890678439
                  // https://devmg.tistory.com/196
                  // https://power-of-optimism.tistory.com/55
                  snackBarView(
                    context: context,
                    message: '앱 화면 크기 ${MediaQuery.of(context).size}\n'
                    '앱 화면 높이 ${MediaQuery.of(context).size.height}\n'
                    '앱 화면 넓이 ${MediaQuery.of(context).size.width}\n'
                    '화면 배율 ${MediaQuery.of(context).devicePixelRatio}\n'
                    // orientation
                    // 디바이스의 방향 (landscape(가로 모드), portrait(세로 모드))
                    '디바이스의 방향 ${MediaQuery.of(context).orientation}\n'
                    // padding
                    // 디바이스의 화면 가장자리 패딩(상태 표시줄, 내비게이션 바, 노치 영역 등)
                    '상단 ${MediaQuery.of(context).padding.top}\n'
                    '하단 ${MediaQuery.of(context).padding.bottom}\n'
                    '왼쪽 ${MediaQuery.of(context).padding.left}\n'
                    '오른쪽 ${MediaQuery.of(context).padding.right}\n'
                    // viewInsets
                    // 키보드가 올라왔을 때 하단의 인셋 값 확인
                    '상태 표시줄 높이 ${MediaQuery.of(context).viewInsets}\n'
                  );
                },
                child: const Text('디바이스 크기')
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 안드로이드의 앱 설정으로 이동
void _openNotificationSettings() async {
  const intent = AndroidIntent(
    action: 'action_application_details_settings',
    data: 'package:com.example.flutterfirstapp',
  );
  await intent.launch();
}

// iOS 앱 설정으로 이동
void _openSettingsApp() async {
  const url = 'app-settings:';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

// 참고 사이트
// https://eunjin3786.tistory.com/333
// https://deku.posstree.com/ko/flutter/device_info_plus
// https://blog.naver.com/chandong83/222332633807

Future<List<String?>> packageInfoGet() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  List<String?> getPackageInfo = [];
  getPackageInfo.add(packageInfo.appName);
  getPackageInfo.add(packageInfo.installerStore);
  getPackageInfo.add(packageInfo.version);
  getPackageInfo.add(packageInfo.buildSignature);
  getPackageInfo.add(packageInfo.buildNumber);
  showToast(msg: getPackageInfo.toString());
  return getPackageInfo;
}

Future<String> iosInfo() async {
  var machineId = '';
  var productName = '';
  final deviceInfoPlugin = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var deviceData = await deviceInfoPlugin.iosInfo;
    machineId = deviceData.utsname.machine;
    productName = machineId.iOSProductName;

   return productName;
  }
  return productName;
}

void batteryState({
  required BuildContext context,
}) {
  var battery = Battery();
  battery.onBatteryStateChanged.listen((BatteryState state) {
    switch(state) {
      case BatteryState.full:
        snackBarView(
          context: context,
          message: '배터리 완전 충전 됨'
        );
      break;
      case BatteryState.charging:
        snackBarView(
          context: context,
          message: '배터리 충전 중'
        );
      break;
      case BatteryState.connectedNotCharging:
        snackBarView(
          context: context,
          message: '외부 장치와 연결 중, 배터리 충전은 되지 않음'
        );
      break;
      case BatteryState.discharging:
        snackBarView(
          context: context,
          message: '배터리 현재 에니지 잃는 중'
        );
      break;
      case BatteryState.unknown:
        snackBarView(
          context: context,
          message: '배터리 상태 알 수 없음'
        );
      break;
    }
  });
}
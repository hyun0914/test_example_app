import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ios_utsname_ext/extension.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package_widget01_screen.dart';
import 'widget/default_scaffold.dart';

class DeviceInfoScreen extends StatelessWidget {
  const DeviceInfoScreen({super.key});

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

              ElevatedButton(
                onPressed: () {
                  // 참고 사이트
                  // https://childcare-daddy.tistory.com/5
                  // https://zeddios.tistory.com/1123
                  if(Platform.isAndroid) {
                    print('android');
                  }
                  else if(Platform.isIOS) {
                    print('IOS');
                  }
                  else if(kIsWeb) {
                    print('Web');
                  }
                },
                child: const Text('플랫폼(Platform) 체크')
              ),

              ElevatedButton(
                onPressed: () => packageInfoGet(),
                child: const Text('package_info_plus  테스트')
              ),

              ElevatedButton(
                onPressed: () => iosInfo(),
                child: const Text('ios_utsname_ext  테스트')
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
  print(getPackageInfo);
  return getPackageInfo;
}

Future<void> iosInfo() async {
  var machineId = '';
  var productName = '';
  final deviceInfoPlugin = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var deviceData = await deviceInfoPlugin.iosInfo;
    machineId = deviceData.utsname.machine;
    productName = machineId.iOSProductName;

    print(productName);
  }
}
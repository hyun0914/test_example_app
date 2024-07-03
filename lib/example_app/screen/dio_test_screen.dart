import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'widget/default_scaffold.dart';

// 참고 사이트 flutter dio download uri
// https://stackoverflow.com/questions/59616610/how-can-i-download-file-using-flutter-dio

class DioTestScreen extends StatelessWidget {
  const DioTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => dioDown(),
              child: const Text('DIO 다운 테스트')
            )
          ],
        ),
      ),
    );
  }
}

void dioDown() async {
  Dio dio = Dio();
  NotificationService notificationService = NotificationService();

  bool permissionReady;
  permissionReady = await checkPermission();

  if(permissionReady) {
    dynamic localPath;
    await findLocalPath().then((value) {
      localPath = value;
    });

    await prepareSaveDir(localPath: localPath);
    print(localPath);

    String filename = 'test.png';
    String filename2 = 'test.png';

    String downloadPath  = localPath + 'test.png';
    String downloadUrl = 'https://www.lego.com/cdn/cs/set/assets/blt742e8599eb5e8931/40649.png';

    bool checkFile = await File(downloadPath).exists();

  //중복 파일 체크
  if(checkFile) {
    String filename_1 = filename.replaceAll('.png', '');
    String filename2_1 = filename2.replaceAll('.png', '');
    for(int i=1; i<99; i++) {
      //숫자 붙힌 파일 중복 체크
      bool checkFile2 = await File(localPath+'$filename_1($i).png').exists();
      if(!checkFile2) {
        filename2 = '$filename2_1($i).png';
        downloadPath = localPath+'$filename_1($i).png';
        break;
      }
    }
  }

    // final response = await dio.download(
    //    downloadUrl,
    //    downloadPath,
    //   onReceiveProgress: (count, total) {
    //     notificationService.createNotification(
    //       100, ((count / total) * 100).toInt(), 0, localPath, filename2
    //     );
    //   }
    // );
    // print(response.statusCode);
  }
}

// 안드로이드 권한 체크, ios는 안함(true), 둘다 아닐경우 false
Future<bool> checkPermission() async {
  // android 체크
  if (Platform.isAndroid) {
    // android 장치 정보 가져오기
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    // 스토리지 퍼미션 상태 확인 스토리지 퍼미션 요청
    var status = await Permission.storage.status;
    if (androidInfo.version.sdkInt <= 32) {
      status = await Permission.storage.status;
      final result = await Permission.storage.request();
      // 퍼미션이 부여되었는지 확인하여 결과를 반환
      if (status != PermissionStatus.granted) {
        if (result == PermissionStatus.granted) {
          return true;
        }
      }
      else {
        return true;
      }
    }
    else {
      return true;
    }
  }
  else {
    return true;
  }
  return false;
}

//다운로드 완료시 알람 보내기
int count2 = 0;
class NotificationService {
  //Hanle displaying of notifications.
  static final NotificationService _notificationService = NotificationService._internal();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings = const AndroidInitializationSettings('ic_launcher');

  var iosDetails = const DarwinInitializationSettings(
    defaultPresentAlert: true,
    defaultPresentBadge: true,
    defaultPresentSound: true,
  );

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal() {
    init();
  }

  void init() async {
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: _androidInitializationSettings,
      iOS: iosDetails,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> createNotification(int count, int i, int id, String downloadPath, String downloadName) async {
    // 알림 그룹 키
    String groupKey = '${count2++}';
    // 알림 채널
    const String groupChannelId = 'downloadChannel';
    // 채널 이름
    const String groupChannelName = 'downloadName';
    // 채널 설명
    const String groupChannelDescription = '다운로드 후 알림';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        groupChannelId, groupChannelName,
        channelDescription: groupChannelDescription,
        channelShowBadge: false,
        groupKey: groupKey,
        setAsGroupSummary: true,
        importance: Importance.max,
        priority: Priority.high,
        onlyAlertOnce: false,
        showProgress: false,
        maxProgress: count,
        progress: i);
    var initializationSettingsIOS = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: initializationSettingsIOS
    );
    if (i == 100) {
      await _flutterLocalNotificationsPlugin.show(
        id, downloadName, '다운로드가 완료되었습니다.', platformChannelSpecifics,
        payload: downloadPath
      );
    }
    await _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (payload) async {
        await OpenFile.open(payload.payload).then((value) {});
      },
    );
  }
}

// 폴더 존재하지 않으면 폴더 생성
Future<void> prepareSaveDir({
  required  String localPath,
}) async {
  localPath = (await findLocalPath());
  final savedDir = Directory(localPath);
  bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    savedDir.create();
  }
}

//OS 체크 후 경로 지정
Future<String> findLocalPath() async {
  // android 경우
  // Android 기본 다운로드 폴더 경로를 반환
  if (Platform.isAndroid) {
    return "/storage/emulated/0/Download";
  }
  // ios 경우
  // path_provider 패키지를 사용하여 애플리케이션의 문서 디렉토리 경로 가져오기
  // 경로에 "Download" 디렉토리를 추가하여 완전한 로컬 저장소 경로를 구성
  else {
    var directory = await getApplicationDocumentsDirectory();
    return '${directory.path}${Platform.pathSeparator}Download';
  }
}
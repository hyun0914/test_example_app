import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:test_example_app/select_home.dart';

// 디버그 모드 kDebugMode
// 릴리즈 모드 kReleaseMode
// import 'package:flutter/foundation.dart'; 필수
// 참고 사이트
// https://dalgonakit.tistory.com/185

void main() async {
  ImageCacheSetting();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  // 이렇게 하면 화면 이동이 천천히 움직 인다.
  //timeDilation = 15.0;
  runApp(
      DevicePreview(
        enabled: !kDebugMode, // kReleaseMode
        builder: (BuildContext context) {
          return const SelectHome();
        },
      )
  );
}

// 참고 사이트
// https://dev-in-gym.tistory.com/20
class ImageCacheSetting extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    ImageCache imageCache = super.createImageCache();

    imageCache.maximumSizeBytes = 200 * 1024 * 1024;

    return imageCache;
  }
}
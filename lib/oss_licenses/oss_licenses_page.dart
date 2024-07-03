import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../oss_licenses.dart';

// https://pub.dev/packages/flutter_oss_licenses
// flutter_oss_licenses: ^2.0.1
// pubspec.yaml 추가 후 아래 명령어를 터미널에 입력
// flutter pub run flutter_oss_licenses:generate.dart

class OssLicensesPage extends StatelessWidget {
  const OssLicensesPage({super.key});

  static Future<List<Package>> loadLicenses() async {

    // oss_licenses.dart 의 ossLicenses 리스트 항목이 수정 후
    // 아래 부분을 주석 처리 해야 리스트에서 항목이 사라진다.

    // final lm = <String, List<String>>{};
    // await for (var l in LicenseRegistry.licenses) {
    //   for (var p in l.packages) {
    //     final lp = lm.putIfAbsent(p, () => []);
    //     lp.addAll(l.paragraphs.map((p) => p.text));
    //   }
    // }
    final licenses = allDependencies.toList();
    // for (var key in lm.keys) {
    //   licenses.add(Package(
    //     name: key,
    //     description: '',
    //     authors: [],
    //     version: '',
    //     license: lm[key]!.join('\n\n'),
    //     isMarkdown: false,
    //     isSdk: false,
    //     isDirectDependency: false,
    //   ));
    // }
    return licenses..sort((a, b) => a.name.compareTo(b.name));
  }

  static final _licenses = loadLicenses();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('오픈소스 라이센스'),),
      body: SafeArea(
        child: FutureBuilder<List<Package>>(
          future: _licenses,
          initialData: const [],
          builder: (context, snapshot) {
              return ListView.separated(
                  padding: const EdgeInsets.all(0),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final package = snapshot.data![index];
                    return ListTile(
                      title: Text(package.name), // package.version
                      //subtitle: package.description.isNotEmpty ? Text(package.description) : null,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MiscOssLicenseSingle(package: package),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider()
              );
            }
        ),
      ),
    );
  }
}

class MiscOssLicenseSingle extends StatelessWidget {
  final Package package;

  const MiscOssLicenseSingle({super.key, required this.package});

  String _bodyText() {
    return package.license!.split('\n').map((line) {
      if (line.startsWith('//')) line = line.substring(2);
      line = line.trim();
      return line;
    }).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(package.name,),), // package.version
      body: SafeArea(
        child: Container(
          color: Theme.of(context).canvasColor,
          child: ListView(
            children: [
              if (package.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                child: Text(package.description, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold))
              ),
              if (package.homepage != null)
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                child: InkWell(
                  child: Text(package.homepage!, style: const TextStyle(color: Colors.green, decoration: TextDecoration.underline)),
                  onTap: () => launchUrl(Uri.parse(package.homepage!)),
                )
              ),
              if (package.description.isNotEmpty || package.homepage != null) const Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                child: Text(_bodyText(), style: Theme.of(context).textTheme.bodyMedium),
              ),
            ]
          )
        ),
      ),
    );
  }
}
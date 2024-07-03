import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

import 'widget/default_scaffold.dart';

class AddressSearchScreen extends StatelessWidget {
  const AddressSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 참고 사이트 https://dkswnkk.tistory.com/322
            ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => KpostalView(callback: (Kpostal result) { print(result.address); },))
                );
              },
              child: const Text('kpostal 주소 검색')
            ),
            const SizedBox(height: 20,),
            // 참고 사이트 https://velog.io/@end75814/flutter-%EC%A3%BC%EC%86%8C%EA%B2%80%EC%83%89-API-%EC%82%AC%EC%9A%A9
            ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).push(CupertinoPageRoute(builder: (context) => RemediKopo()));
              },
              child: const Text('remedi_kopo 주소 검색')
            )
          ],
        ),
      ),
    );
  }
}

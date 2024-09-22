import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

import 'widget/default_scaffold.dart';
import 'widget/snack_bar_view.dart';

class AddressSearchScreen extends StatelessWidget {
  const AddressSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // 참고 사이트 https://dkswnkk.tistory.com/322
              ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => KpostalView(callback: (Kpostal result) {
                      snackBarView(
                        context: context,
                        message: 'result: $result\n'
                        'address: ${result.address}\n'
                      );
                    },))
                  );
                },
                child: const Text('kpostal 주소 검색')
              ),
            ],
          ),
        ),
      ),
    );
  }
}

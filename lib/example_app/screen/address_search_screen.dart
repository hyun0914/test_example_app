import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

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
              const SizedBox(height: 20,),
              // 참고 사이트 https://velog.io/@end75814/flutter-%EC%A3%BC%EC%86%8C%EA%B2%80%EC%83%89-API-%EC%82%AC%EC%9A%A9
              ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context).push(CupertinoPageRoute(builder: (context) => RemediKopo())).then((value) {
                    snackBarView(
                      context: context,
                      message: 'KopoModel class\n'
                      'address: ${value.address}\n'
                      'addressEnglish : ${value.addressEnglish}\n'
                      'addressType : ${value.addressType}\n'
                      'apartment : ${value.apartment}\n'
                      'autoJibunAddress : ${value.autoJibunAddress}\n'
                      'autoJibunAddressEnglish : ${value.autoJibunAddressEnglish}\n'
                      'autoRoadAddress : ${value.autoRoadAddress}\n'
                      'autoRoadAddressEnglish : ${value.autoRoadAddressEnglish}\n'
                      'bcode : ${value.bcode}\n'
                      'bname : ${value.bname}\n'
                      'bname1 : ${value.bname1}\n'
                      'bname2 : ${value.bname2}\n'
                      'buildingCode : ${value.buildingCode}\n'
                      'buildingName : ${value.buildingName}\n'
                      'hashCode : ${value.hashCode}\n'
                      'hname : ${value.hname}\n'
                      'jibunAddress : ${value.jibunAddress}\n'
                      'jibunAddressEnglish : ${value.jibunAddressEnglish}\n'
                      'noSelected : ${value.noSelected}\n'
                      'postcode : ${value.postcode}\n'
                      'postcode1 : ${value.postcode1}\n'
                      'postcode2 : ${value.postcode2}\n'
                      'postcodeSeq : ${value.postcodeSeq}\n'
                      'query : ${value.query}\n'
                      'roadAddress : ${value.roadAddress}\n'
                      'roadAddressEnglish : ${value.roadAddressEnglish}\n'
                      'roadname : ${value.roadname}\n'
                      'roadnameCode : ${value.roadnameCode}\n'
                      'runtimeType : ${value.runtimeType}\n'
                      'sido : ${value.sido}\n'
                      'sigungu : ${value.sigungu}\n'
                      'sigunguCode : ${value.sigunguCode}\n'
                      'userLanguageType : ${value.userLanguageType}\n'
                      'userSelectedType : ${value.userSelectedType}\n'
                      'zonecode : ${value.zonecode}\n'
                    );
                  });
                },
                child: const Text('remedi_kopo 주소 검색')
              )
            ],
          ),
        ),
      ),
    );
  }
}

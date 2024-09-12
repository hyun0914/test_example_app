import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'widget/default_scaffold.dart';

class PinPutPackagesScreen extends StatelessWidget {
  const PinPutPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Center(
        child: Pinput(

        ),
      ),
    );
  }
}

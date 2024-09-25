import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'widget/default_scaffold.dart';

class FlutterSlidAblePackageScreen extends StatefulWidget {
  const FlutterSlidAblePackageScreen({super.key});

  @override
  State<FlutterSlidAblePackageScreen> createState() => _FlutterSlidAblePackageScreenState();
}

class _FlutterSlidAblePackageScreenState extends State<FlutterSlidAblePackageScreen> with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: ListView(
        children: [
          Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {}),
              children: [
                SlidableAction(
                  onPressed: (BuildContext context) {},
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (BuildContext context) {},
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Share',
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) => controller.openEndActionPane(),
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                  icon: Icons.photo,
                  label: 'Photo',
                ),
                SlidableAction(
                  onPressed: (_) => controller.close(),
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
             ],
            ),
            child: const ListTile(
              tileColor: Colors.blueGrey,
              contentPadding: EdgeInsets.all(10),
              title: Text('Slide me')
            ),
          ),
        ],
      ),
    );
  }
}

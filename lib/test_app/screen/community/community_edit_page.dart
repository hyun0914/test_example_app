import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../layout/simple_bar_layout.dart';

final ImagePicker picker = ImagePicker();
List<XFile> _imageFile2 = [];
final titleController = TextEditingController();
final contentController = TextEditingController();

class CommunityEditPage extends StatefulWidget {
  const CommunityEditPage({super.key});

  @override
  State<CommunityEditPage> createState() => _CommunityEditPageState();
}

class _CommunityEditPageState extends State<CommunityEditPage> {

  @override
  Widget build(BuildContext context) {
    return SimpleBarLayout(
      title: '커뮤니글 수정',
      topIcon: null,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent
                ),
                child: const Text('글 수정', style: TextStyle(fontSize: 17, color: Colors.indigoAccent),)
              ),
            ),
          ],
        ),
      ),
      children: const [
        Expanded(
          child:
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              WiringFrom(getContext: '내용',),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 10),
                  child: ImagesFrom(),
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }
}

class WiringFrom extends StatelessWidget {
  final String getContext;
  const WiringFrom({
    required this.getContext,
    super.key});

  @override
  Widget build(BuildContext context) {
    return wiringFrom(context);
  }

  SliverList wiringFrom(BuildContext context){
    contentController.text = getContext;
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/2,
                child: TextField(
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ]
      )
    );
  }
}

class ImagesFrom extends StatefulWidget {
  const ImagesFrom({super.key});

  @override
  State<ImagesFrom> createState() => _ImagesFromState();
}

class _ImagesFromState extends State<ImagesFrom> {

  @override
  Widget build(BuildContext context) {
    return imgFrom();
  }

  Widget imgFrom() {
    List<Widget> boxContents = [
      IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: (){
          takePhoto(ImageSource.gallery);
        },
        icon: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.6), shape: BoxShape.circle),
          child: const Icon(
            CupertinoIcons.camera,
            color: Colors.green,
          ),
        )
      ),
      Container(),
      Container(),
      _imageFile2.length <=4
          ? Container()
          : FittedBox(
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            shape: BoxShape.circle
          ),
          child: Text('+${(_imageFile2.length -4).toString()}',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
      )
    ];

    return SizedBox(
      height: 200,
      child: GridView.count(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(2),
        crossAxisCount: 4,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        children: List.generate(4, (index) => DottedBorder(
            color: Colors.green,
            dashPattern: const [5,3],
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            child: Container(
              decoration: index <= _imageFile2.length-1
                ? BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(File(_imageFile2[index].path))))
                : null,
              child: Center(child: boxContents[index]),
            ),
          ),
        ),
      ),
    );
  }

  takePhoto(ImageSource source) async{
    final List<XFile> pickedFile = await picker.pickMultiImage();

    setState(() {
      // _imageFile = pickedFile!;
      _imageFile2 = pickedFile;
    });
  }
}


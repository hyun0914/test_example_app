import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../layout/simple_bar_layout.dart';

// 참고 사이트
// https://kyungsnim.net/126

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}
class _ProfileEditPageState extends State<ProfileEditPage> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleBarLayout(
      title: '프로필 변경',
      topIcon: null,
      children: [
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 20,),
              imageProfile(),
              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('현재닉네임: 없다', style: TextStyle(fontSize: 17),),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: nameText(),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                    onPressed: () {},
                    child: const Text('변경하기', style: TextStyle(fontSize: 17, color: Colors.indigoAccent),),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget imageProfile(){
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: _imageFile == null ? const AssetImage('assets/images/chicken.jpg') : FileImage((File(_imageFile!.path))) as ImageProvider,
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: InkWell(
              onTap: (){
                // showModalBottomSheet(context: context,  builder: (builder) => bottomsheet());
                takePhoto(ImageSource.gallery);
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.black.withOpacity(0),
                size: 140,
              ),
            )
          )
        ],
      ),
    );
  }

  Widget nameText(){
    return TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.black,
        ),
        labelText: '닉네임',
      ),
    );
  }

  takePhoto(ImageSource source) async{
    final pickedFile  = await _picker.pickImage(source: source, imageQuality: 99, maxWidth: 2000, maxHeight: 2000,);
    setState(() {
      _imageFile = pickedFile;
    });
  }
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import 'widget/default_scaffold.dart';

// 이미지 성능 비교
// https://kibua20.tistory.com/235

// extended_image(캐시 이미지 패캐지)
// 예시 코드 ExtendedImage.asset('assets/images/image.png'),

String urlImg = 'https://i.pinimg.com/736x/26/ef/03/26ef03ec8c0751b4edc938fc8f7b634e.jpg';

Future<List<ImageFile>> pickImagesUsingImagePicker(bool allowMultiple) async {
  final picker = ImagePicker();
  final List<XFile> xFiles;
  if (allowMultiple) {
    xFiles = await picker.pickMultiImage(maxWidth: 1080, maxHeight: 1080);
  }
  else {
    xFiles = [];
    final xFile = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080);
    if (xFile != null) {
      xFiles.add(xFile);
    }
  }
  if (xFiles.isNotEmpty) {
    return xFiles.map<ImageFile>((e) => convertXFileToImageFile(e)).toList();
  }
  return [];
}

MultiImagePickerController multiImgController = MultiImagePickerController(
  maxImages: 5,
    picker: (allowMultiple) async {
      return await pickImagesUsingImagePicker(allowMultiple);
    }
  );

List<String> imageName = [];
XFile? imageFile;
final ImagePicker picker = ImagePicker();

dynamic file;
Future<dynamic> cacheManagerFunction() async {
  file = await DefaultCacheManager().getSingleFile(urlImg);
  return file;
}

final ImagePicker picker2 = ImagePicker();
List<XFile> imageFile2 = [];

class CacheImageWidgetScreen extends StatefulWidget {
  const CacheImageWidgetScreen({super.key});

  @override
  State<CacheImageWidgetScreen> createState() => _CacheImageWidgetScreenState();
}

class _CacheImageWidgetScreenState extends State<CacheImageWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> boxContents = [
      IconButton(
        onPressed: (){
          takePhoto(ImageSource.gallery);
        },
        icon: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6), shape: BoxShape.circle
          ),
          child: Icon(
            CupertinoIcons.camera,
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ),
      Container(),
      Container(),
      imageFile2.length <=4?
      Container()
      : FittedBox(
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            shape: BoxShape.circle
          ),
          child: Text('+${(imageFile2.length -4).toString()}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
      ),
    ];

    return DefaultScaffold(
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 12,),
            selectPhoto(source: ImageSource.gallery),
            const SizedBox(height: 30,),

            SizedBox(
              height: 280,
              child: MultiImagePickerView(
                controller: multiImgController,
                padding: const EdgeInsets.all(10),
              ),
            ),

            // 참고 사이트
            // https://velog.io/@dosilv/Flutter-%EC%9D%B4%EB%AF%B8%EC%A7%80-%EC%97%85%EB%A1%9C%EB%8D%94-%EB%A7%8C%EB%93%A4%EA%B8%B0
            SizedBox(
              height: 440,
              child: GridView.count(
                padding: const EdgeInsets.all(2),
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: List.generate(
                  4, (index) => Container(
                    decoration: index <= imageFile2.length-1
                    ? BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(imageFile2[index].path))
                      )
                    )
                    : null,
                    child: Center(child: boxContents[index]),
                  ),
                ),
              ),
            ),

            // 참고 사이트
            // https://dalgonakit.tistory.com/118
            CachedNetworkImage(
              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzI7_cvbc0a3ZzlMeePRzmvU8ePhiC6SlRhw&usqp=CAU",
              imageBuilder: (context, imageProvider) => CircleAvatar(radius: 10, backgroundImage: imageProvider,),
              // 로딩되는 동안 표시되는 위젯
              placeholder: (context, url) => const CircularProgressIndicator(),
              // 에러일때 표시되는 위젯
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 4,),

            StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
                return Column(
                  children: [
                    file == null?
                     const SizedBox()
                    : Image.file(file),
                    ElevatedButton(
                      onPressed: () => cacheManagerFunction().then((value) {
                        setState(() {
                          file = value;
                        });
                      }),
                      child: const Text('flutter_cache_manager 패키지'),
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: 4,),
            FastCachedImage(url: urlImg),
            const SizedBox(height: 4,),
          ],
        ),
      ),
    );
  }

  takePhoto(ImageSource source) async{
    final List<XFile> pickedFile2 = await picker2.pickMultiImage();
    setState(() {
      imageFile2 = pickedFile2;
    });
  }

  Future<bool> imgName(ImageSource source) async {
    final pickedFile  = await picker.pickImage(source: source, imageQuality: 99, maxWidth: 2000, maxHeight: 2000,);
    if(pickedFile != null) {
      setState((){
        imageFile = pickedFile;
      });
      return true;
    }
    else {
      return false;
    }
  }

  Widget selectPhoto({
    required ImageSource source,
  }) {
    return GestureDetector(
      onTap: () => imageEditSheet(contexts: context, source: source),
      child: companyImg(
        imgFile: imageName.isEmpty? '' : imageName.first,
        radius: 35,
        profileBasics: 'hamburger.png'
      ),
    );
  }

  Future imageEditSheet({
    required BuildContext contexts,
    required ImageSource source,
  }) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      context: contexts,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 14, bottom: 24),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      imgName(source).then((value) {
                        if(value == true) {
                          print(imageFile!.path);
                          imageName.add(imageFile!.path);
                          Navigator.of(context).pop();
                        }
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(bottom: 14),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image),
                          SizedBox(width: 12),
                          Text('사진 선택'),
                        ],
                      )
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(top: 14, bottom: 14),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          top: BorderSide(color: Color.fromRGBO(219, 219, 219, 1)),
                          bottom :BorderSide(color: Color.fromRGBO(219, 219, 219, 1)),
                        )
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt),
                          SizedBox(width: 12,),
                          Text('사진 삭제'),
                        ],
                      )
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(top: 14),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('닫기'),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}

Widget companyImg({
  required String imgFile,
  required double radius,
  required String profileBasics,
}) {
  if(imgFile == '') {
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      backgroundImage: AssetImage('assets/images/$profileBasics',),
      //backgroundImage: NetworkImage(),
    );
  }
  else {
    return Image.file(File(imageFile!.path), width: 100, height: 100,);
  }
}
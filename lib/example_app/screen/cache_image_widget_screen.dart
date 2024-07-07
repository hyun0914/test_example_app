import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';

import 'widget/default_scaffold.dart';

// 이미지 성능 비교
// https://kibua20.tistory.com/235

// extended_image(캐시 이미지 패캐지)
// 예시 코드 ExtendedImage.asset('assets/images/image.png'),

String urlImg = 'https://i.pinimg.com/736x/26/ef/03/26ef03ec8c0751b4edc938fc8f7b634e.jpg';

class CacheImageWidgetScreen extends StatelessWidget {
  const CacheImageWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 12,),
            selectPhoto(source: ImageSource.gallery),
            const SizedBox(height: 4,),

            // 참고 사이트
            // https://dalgonakit.tistory.com/118
            CachedNetworkImage(
              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzI7_cvbc0a3ZzlMeePRzmvU8ePhiC6SlRhw&usqp=CAU",
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
}
List<String> imageName = [];
XFile? imageFile;
final ImagePicker picker = ImagePicker();

Future imageEditSheet({
  required BuildContext contexts,
  required ImageSource source,
  required Function(void Function()) setState,
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
                    imgName(setState, source).then((value) {
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

Future<bool> imgName(setState, ImageSource source) async {
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
  return StatefulBuilder(
    builder: (BuildContext context, setState) {
      return GestureDetector(
        onTap: () => imageEditSheet(contexts: context, source: source, setState: setState),
        child: companyImg(
          imgFile: urlImg,
          radius: 35,
          profileBasics: 'hamburger.png'
        ),
      );
    },
  );
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
  return CachedNetworkImage(
    imageUrl: imgFile,
    imageBuilder: (context, imageProvider) => CircleAvatar(radius: radius, backgroundImage: imageProvider,),
    placeholder: (context, url) => CircleAvatar(radius: radius,),
    errorWidget: (context, url, error) => Image.asset('assets/images/$profileBasics',),
  );
}

dynamic file;
Future<dynamic> cacheManagerFunction() async {
  file = await DefaultCacheManager().getSingleFile(urlImg);
  return file;
}
import 'dart:io';
import 'dart:ui';

// import 'package:image_pickers/image_pickers.dart';

class ImageSelector {
  // Future<File> selectImage() async {
  //   List<Media> _listImagePaths = await ImagePickers.pickerPaths(
  //       galleryMode: GalleryMode.image,
  //       selectCount: 1,
  //       showGif: false,
  //       showCamera: true,
  //       compressSize: 500,
  //       uiConfig: UIConfig(uiThemeColor: Color(0xff000000)),
  //       cropConfig: CropConfig(enableCrop: false, width: 2, height: 2));

  //   if(_listImagePaths!=null){
  //     File result = File(_listImagePaths[0].path);
  //     return result;
  //   }
  //   return null;
  // }

  // Future<File> selectImageWithOutCamera({int count = 0}) async {
  //   List<Media> _listImagePaths = await ImagePickers.pickerPaths(
  //       galleryMode: GalleryMode.image,
  //       selectCount: count,
  //       showGif: false,
  //       showCamera: false,
  //       compressSize: 500,
  //       uiConfig: UIConfig(uiThemeColor: Color(0xff000000)),
  //       cropConfig: CropConfig(enableCrop: true, width: 3, height: 2));

  //   if(_listImagePaths!=null){
  //     File result = File(_listImagePaths[0].path);
  //     return result;
  //   }
  //   return null;
  // }


  // Future<File> selectImageFromCamera()async{

  //   Media media = await ImagePickers.openCamera(cameraMimeType: CameraMimeType.photo,compressSize: 500);
  //   if(media!=null){
  //     return  File(media.path);
  //   }
  //   return null;

  // }

}

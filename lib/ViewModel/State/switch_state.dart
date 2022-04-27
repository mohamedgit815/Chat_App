import 'dart:io';
import '../../Helper/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


class SwitchState extends ChangeNotifier{
  bool varSwitch = true;
  late String value = '';
  int count = 0;
  File? fileImage;
  final List<Widget> pages = const [
    // MainHomeScreen() ,
    // MainFriendsScreen() ,
  ];

  String funcChange(String v){
    notifyListeners() ;
    return value = v;
  }

  void equalNull(){
     value = '';
     notifyListeners();
  }

  bool funcSwitch(){
   notifyListeners();
    return varSwitch = !varSwitch;
  }

  bool trueSwitch(){
   notifyListeners();
   return varSwitch = true;
  }

  bool falseSwitch(){
    notifyListeners();
    return varSwitch = false;
  }

  int countState(int v) {
    notifyListeners();
    return count = v;
  }

  Future<void> getImagePicker({required BuildContext context,required ImageSource imageSource}) async {
    try {
      final XFile? _image = await ImagePicker().pickImage(source: imageSource);

      if (_image != null) {
        fileImage = File(_image.path);
      }
      else{
        customSnackBar(text: 'your arn\'t selected Image', context: context);
      }
      notifyListeners();
    }on PlatformException catch(_){
      customSnackBar(text: 'your arn\'t selected Image', context: context);
    }
  }

  void deleteImagePicker(){
    fileImage = null;
    notifyListeners();
  }


}
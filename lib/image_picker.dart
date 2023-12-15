import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/login.dart';

String? imageURl;
class ImagesPicker{
  Future<File?> pickImageFromGallery(BuildContext context) async{
    File? image;
    try{
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(pickedImage != null){
        image = File(pickedImage.path);
        Reference reference = FirebaseStorage.instance.ref().child('profilePic').child(DateTime.now().toString());
        await reference.putFile(image);
        imageURl = await reference.getDownloadURL();
      }
    } catch(e){
      DialogAlert().dialog('Error', e.toString(), context);
    }
    return image;
  }
}
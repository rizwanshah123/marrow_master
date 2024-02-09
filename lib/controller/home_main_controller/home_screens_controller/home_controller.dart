import 'dart:io';
import 'package:automated_bone_marrow_cell_classification_system/data/repository/home_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);

  final HomeRepository _homeRepository = HomeRepository();
  Future<void> pickImageFromGallery() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      _homeRepository.uploadImage(selectedImage.value!.path).then((response) {
        print("below is the main response ");
        print(response);
        Map<String, dynamic> predictions = response['predictions'];
        // print('predictions: $predictions');
        List<MapEntry<String, dynamic>> entries = predictions.entries.toList();
        MapEntry<String, dynamic> firstEntry = entries[0];
        String value = firstEntry.value;
        List<String> splitDescription = value.split(': ');
        String name = splitDescription[0];
        String description = splitDescription[1];
        uploadImageToHistory(name, description);
      }).catchError((error) {
        print('Error uploading image: $error');
        // Handle error here if necessary
      });
    } else {
      Get.snackbar('Error', 'No image selected',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> captureImageFromCamera() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      _homeRepository.uploadImage(selectedImage.value!.path).then((response) {
        print("below is the main response ");
        print(response);
        Map<String, dynamic> predictions = response['predictions'];
        // print('predictions: $predictions');
        List<MapEntry<String, dynamic>> entries = predictions.entries.toList();
        MapEntry<String, dynamic> firstEntry = entries[0];
        String value = firstEntry.value;
        List<String> splitDescription = value.split(': ');
        String name = splitDescription[0];
        String description = splitDescription[1];
        uploadImageToHistory(name, description);
      }).catchError((error) {
        print('Error uploading image: $error');
        // Handle error here if necessary
      });
    } else {
      Get.snackbar('Error', 'No image selected',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> uploadImageToHistory(String name, String description) async {
    try {
      print("Upload history is called");
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      print("current user is $auth.currentUser");
      final String imageURL =
          await uploadImageToFirebaseStorage(selectedImage.value!);
      print("image URL is $imageURL");
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formattedDate = formatter.format(now);
      await _firestore.collection('history').add({
        'userId': user!.uid,
        'name': name,
        'description': description,
        'image': imageURL,
        'date': formattedDate,
      });
      Get.snackbar('Success', 'Image uploaded to history');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image to history: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      print("Inside the Upload image to firestore");
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      await firebase_storage.FirebaseStorage.instance
          .ref('images/$fileName')
          .putFile(imageFile);

      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('images/$fileName')
          .getDownloadURL();
      print("Downloading");
      return downloadURL;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return '';
    }
  }
}

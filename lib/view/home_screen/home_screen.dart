import 'package:automated_bone_marrow_cell_classification_system/controller/home_main_controller/home_screens_controller/home_controller.dart';
import 'package:automated_bone_marrow_cell_classification_system/view/home_screen/home_screen_component/upload_buttom.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import 'result_screen/result_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff184C9A),
            elevation: 3,
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
            title: const Text(
              'Marrow Master',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Container(
            height: 100.h,
            width: 100.w,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 237, 234, 234)),
            child: Column(children: [
              SizedBox(height: 4.h),
              const Align(
                alignment: Alignment.center,
                child: Text('Unlocking Cell Secrets, One Image at a Time',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 15, 75, 164))),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                  height: 20.h,
                  child: Image.asset(
                    'assets/images/microscope.png',
                    height: 27.h,
                    width: 100.w,
                  )),
              SizedBox(height: 10.h),
              InkWell(
                onTap: () => _homeController.captureImageFromCamera(),
                child: uploadButton(
                  'assets/images/camera.png',
                  'Upload Image From Camera',
                  7.w,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              InkWell(
                onTap: () => _homeController.pickImageFromGallery(),
                child: uploadButton(
                  'assets/images/gallery.png',
                  'Upload Image From Gallery',
                  10.w,
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResultScreen())),
                child: uploadButton(
                  'assets/images/gallery.png',
                  'Upload Image From Gallery',
                  10.w,
                ),
              )
            ]),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../auth_screen/login_screen.dart';

class OnBoradingScreen extends StatelessWidget {
  const OnBoradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Column(children: [
              SizedBox(height: 15.h),
              Image.asset('assets/images/icon.png'),
              SizedBox(height: 2.h),
              const Text('Welcome To',
                  style: TextStyle(
                    wordSpacing: 3,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  )),
              const Text('Marrow Master',
                  style: TextStyle(
                    color: Color(0xff184C9A),
                    wordSpacing: 3,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  )),
              const Text('Explore Automated Cell Classification with Ease',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () => Get.to(() => LoginScreen()),
                child: Container(
                    width: 45.w,
                    height: 8.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff184C9A)),
                    child: const Text('Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ))),
              )
            ])));
  }
}

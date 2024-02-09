import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

Widget uploadButton(String img, String title, double width) {
  return Container(
    height: 8.h,
    width: 95.w,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border.all(width: 3, color: const Color(0xff184C9A)),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        SizedBox(width: 2.w),
        Image.asset(img),
        SizedBox(
          width: 3.w,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(width: width),
        Container(
          height: 10.h,
          width: 8.w,
          decoration: const BoxDecoration(
            color: Color(0xff184C9A),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(
          width: 3.w,
        ),
      ],
    ),
  );
}

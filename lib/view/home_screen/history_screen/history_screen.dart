import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../controller/home_main_controller/history_controller/history_controller.dart';
import 'history_screen_component/view_history_container.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);
  final HistoryController historyController = Get.find<HistoryController>();
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
            'Recent Searches',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            if (historyController.historyItems.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container(
                height: 100.h,
                width: 100.w,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 237, 234, 234)),
                child: SingleChildScrollView(
                  child: Column(
                    children: historyController.historyItems.map((item) {
                      return viewHistoryContainer(
                        context: context,
                        time: item.date,
                        img: item.imageUrl,
                        icon: Icons.calendar_month_outlined,
                        text: item.name,
                        description: item.text,
                      );
                    }).toList(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

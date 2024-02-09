import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  RxList historyItems = [].obs;

  @override
  void onInit() async {
    await fetchHistoryItems();
    super.onInit();
  }

  Future<void> fetchHistoryItems() async {
    print("called the history ");
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('history').get();
    historyItems.clear();
    historyItems.addAll(querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return HistoryItem(
        text: data['description'] as String,
        date: data['date'].toString(),
        imageUrl: data['image'] as String,
        name: data['name'] as String,
        userId: data['userId'] as String,
      );
    }).toList());
  }
}

class HistoryItem {
  final String text;
  final String date;
  final String imageUrl;
  final String name;
  final String userId;

  HistoryItem({
    required this.text,
    required this.date,
    required this.imageUrl,
    required this.name,
    required this.userId,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      text: json['description'] as String,
      date: json['date'].toString(),
      imageUrl: json['image'] as String,
      name: json['name'] as String,
      userId: json['userId'] as String,
    );
  }
}

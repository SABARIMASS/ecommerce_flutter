import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sephora/app/modules/product/view/product_list_view.dart';

class DashBoardController extends GetxController {
  var selectedIndex = 0.obs;
  List<Widget> pages = [
    ProductListView(),
    Center(
      child: Text(
        'Stay Tuned',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    ),
    Center(
      child: Text(
        'Stay Tuned',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    ),
    Center(
      child: Text(
        'Stay Tuned',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    ),
    Center(
      child: Text(
        'Stay Tuned',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    ),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

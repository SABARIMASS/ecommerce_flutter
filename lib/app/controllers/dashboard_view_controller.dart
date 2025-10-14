import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sephora/app/views/product/view/product_list_view.dart';

class DashBoardController extends GetxController {
  var selectedIndex = 0.obs;
  List<Widget> pages = [
    // Add your pages here
    ProductListView(), // Home
    Container(color: const Color(0xFFFFF3E0)), // Shop
    Container(color: const Color(0xFFE8F5E9)), // Offers
    Container(color: const Color(0xFFFFEBEE)), // Me
    Container(color: const Color(0xFFF3E5F5)), // Community
    Container(color: const Color(0xFFE0F7FA)), // My Store
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

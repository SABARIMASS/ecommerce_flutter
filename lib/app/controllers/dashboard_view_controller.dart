import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sephora/app/modules/product/view/product_list_view.dart';

class DashBoardController extends GetxController {
  var selectedIndex = 0.obs;
  List<Widget> pages = [
    ProductListView(),
    ProductListView(),
    ProductListView(),
    ProductListView(),
    ProductListView(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

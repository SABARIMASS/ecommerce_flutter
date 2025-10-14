import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sephora/shared/app_style.dart';
import '../../../controllers/dashboard_view_controller.dart';
import '../widgets/custom_nav_bar_widget.dart';

class DashBoardView extends StatelessWidget {
  DashBoardView({super.key});
  final controller = Get.put(DashBoardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryBackgroundColor,
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: controller.selectedIndex.value,
            children: controller.pages,
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => CustomBottomNavigation(
          selectedIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.selectedIndex.value = index;
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sephora/app/bindings/app_binding.dart';
import 'package:sephora/app/modules/dashboard/view/dashboard_view.dart';
import 'app/routes/app_routes.dart';
import 'app/core/utils/app_screen_size.dart';
import 'shared/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppResponsiveScreenSize.screenSize(context),
      minTextAdapt: true,
      splitScreenMode: true,
      child: DashBoardView(),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SEPHORA',
          theme: themeData,
          home: child,
          initialBinding: AppBindings(),
          getPages: AppPages.routes,
          initialRoute: "/",
          builder: (context, child) {
            return child ?? const SizedBox.shrink();
          },
        );
      },
    );
  }
}

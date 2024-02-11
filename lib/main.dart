import 'package:drawingtool/routing/app_route_name.dart';
import 'package:drawingtool/routing/app_routes.dart';
import 'package:drawingtool/screen/dash_board/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const DrawingTool());
}

class DrawingTool extends StatelessWidget {
  const DrawingTool({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      splitScreenMode: true,
      // useInheritedMediaQuery: true,
      designSize: const Size(690, 360),
      minTextAdapt: true,
      builder: (context,widget){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRouteName.home,
          getPages: AppRoute.routes,
        );
      },

    );
  }
}

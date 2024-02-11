import 'package:drawingtool/screen/dash_board/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DashBoardAppBar extends StatelessWidget implements PreferredSizeWidget {
  DashBoardAppBar({super.key});

  var controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Drawing Tool",
        style: TextStyle(fontSize: 15.sp),
      ),
      actionsIconTheme: IconThemeData(weight: 50),
      actions: [
        IconButton(
            onPressed: () {
              controller.painterController.undo();
            },
            icon: Icon(
              Icons.undo,
              size: 15.sp,
            )),
        IconButton(
            onPressed: () {
              controller.painterController.redo();
            },
            icon: Icon(
              Icons.redo,
              size: 15.sp,
            )),
        IconButton(
            onPressed: () {
              print("Grid tapped");
              controller.isGridVisible.value = !controller.isGridVisible.value;
              controller.painterController.background =
                  controller.isGridVisible.value
                      ?null
                      : Colors.white.backgroundDrawable;
            },
            icon: Obx(() => controller.isGridVisible.value
                ? Icon(
                    Icons.grid_off_sharp,
                    size: 15.sp,
                  )
                : Icon(
                    Icons.grid_on_sharp,
                    size: 15.sp,
                  ))),
        IconButton(
            onPressed: () {
              controller.saveCanvas();
            },
            icon: Icon(
              Icons.save,
              size: 15.sp,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

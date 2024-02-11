import 'package:drawingtool/screen/dash_board/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class DashBoardCanvas extends GetView<DashBoardController> {
  const DashBoardCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(children: [
      Obx(() => controller.isGridVisible.value
          ? Image.asset(
              'assets/grid_light.jpg',
              fit: BoxFit.fitWidth,
              width: double.infinity,
            )
          : Container()),
      LayoutBuilder(
        builder: (context, size) {
          controller.cw = size.maxWidth;
          controller.ch = size.maxHeight;
          return FlutterPainter.builder(
            controller: controller.painterController,
            builder: (BuildContext context, Widget painter) {
              return painter;
            },
          );
        },
      ),
    ]));
  }
}

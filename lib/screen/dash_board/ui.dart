import 'package:drawingtool/screen/dash_board/widgets/app_bar.dart';
import 'package:drawingtool/screen/dash_board/widgets/dashboard_canvas.dart';
import 'package:drawingtool/screen/dash_board/widgets/right_bar.dart';
import 'package:drawingtool/screen/dash_board/widgets/shape_bar/shape_bar_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DashBoardUi extends GetView<DashBoardController> {
  const DashBoardUi({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashBoardAppBar(),
      body: DashBoard(),
    );
  }
}

class DashBoard extends GetView<DashBoardController> {
  const DashBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [ShapeBar(), DashBoardCanvas(), RightBar()],
        ),

    );
  }
}

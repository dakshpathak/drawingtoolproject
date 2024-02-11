import 'package:drawingtool/screen/dash_board/widgets/shape_bar/controller.dart';
import 'package:get/get.dart';

import 'controller.dart';

/// This class is basically used to bind the UI and BUSINESS LOGIC together

class DashBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController());
    Get.lazyPut(() => ShapeBarController());
  }
}

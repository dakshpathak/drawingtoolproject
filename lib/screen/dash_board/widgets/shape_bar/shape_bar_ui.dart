import 'package:drawingtool/utils/brand_colors.dart';
import 'package:drawingtool/utils/svg_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller.dart';

class ShapeBar extends GetView<DashBoardController> {
  const ShapeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      child: Obx(
        () => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            height: 150.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    controller.totalShapes,
                    (index) => ShapeIconButton(
                          onTap: controller.onShapeTaps?[index] ??
                              controller.fallBackTap,
                          icon: controller.shapeSvg?[index] ??
                              SvgIcon.error,
                          isSelected:
                              controller.selectedShapeBarIconIndex.value == index,
                        )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShapeIconButton extends StatelessWidget {
  final Function() onTap;
  final Widget icon;
  final bool isSelected;

  const ShapeIconButton(
      {super.key,
      required this.onTap,
      required this.icon,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor:
            isSelected ? BrandColors.iconBgColor : Colors.transparent,
        child: icon,
      ),
    );
  }
}

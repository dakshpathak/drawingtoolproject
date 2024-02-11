import 'dart:developer';

import 'package:drawingtool/screen/dash_board/controller.dart';
import 'package:drawingtool/utils/brand_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RightBar extends GetView<DashBoardController> {
  const RightBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Color selectedColor = Colors.transparent;
    List<Icon> icons = [
      const Icon(Icons.star),
      const Icon(Icons.favorite),
      const Icon(Icons.thumb_up),
      const Icon(Icons.thumb_down),
      const Icon(Icons.check),
      const Icon(Icons.close),
      const Icon(Icons.admin_panel_settings),
      const Icon(Icons.accessibility_outlined),
      const Icon(Icons.account_balance),
      const Icon(CupertinoIcons.settings),
      const Icon(Icons.ac_unit),
      const Icon(Icons.airplanemode_active),
      const Icon(Icons.attach_file),
      const Icon(Icons.attach_money),
      const Icon(Icons.backup),
      const Icon(Icons.beach_access),
      const Icon(Icons.brush),
      const Icon(Icons.camera_alt),
      const Icon(Icons.cloud),
      const Icon(Icons.desktop_windows),
      const Icon(Icons.directions_bike),
      const Icon(Icons.event),
      const Icon(Icons.fastfood),
      const Icon(Icons.games),
      const Icon(Icons.headset),
      const Icon(Icons.image),
      const Icon(Icons.language),
      const Icon(Icons.mail),

    ];

    return SizedBox(
      width: 50.w,
      child: Column(
        children: [
          /// ICONS
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  height: 25.h,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: BrandColors.iconBgColor, width: 2.w))),
                    child: Center(
                      child: Text("Amenities Icons",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines:2,
                          style: TextStyle(
                              fontSize: 7.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    )),
                Expanded(
                  child: Padding(

                    padding: EdgeInsets.symmetric(vertical:5.h,horizontal: 5.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children:
                                    icons.sublist(0, icons.length ~/ 2).map((icon) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 2.w),
                                    child: Draggable<Icon>(
                                      data: icon,
                                      child: Icon(
                                        icon.icon,
                                        size: 13.sp,
                                      ),
                                      feedback: icon,
                                      childWhenDragging: icon,
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(width: 5.w,),
                              Column(
                                children: icons.sublist(icons.length ~/ 2).map((icon) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 2.w),
                                    child: Draggable<Icon>(
                                      data: icon,
                                      child: Icon(
                                        icon.icon,
                                        size: 13.sp,
                                      ),
                                      feedback: icon,
                                      childWhenDragging: icon,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


          /// Color Palette
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                    height: 15.h,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: BrandColors.iconBgColor, width: 2.w))),
                    child: Center(
                      child: Text("Color",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines:1,
                          style: TextStyle(
                              fontSize: 7.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    )),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => Container(
                        height: 15.sp,
                        width: 15.sp,
                        decoration: BoxDecoration(
                          color: controller.selectedColor.value,
                          border: Border.all(color: Colors.blue, width: 1.5),
                          borderRadius:
                           BorderRadius.all(Radius.circular(5.r)),
                        ))),
                              SizedBox(width: 5.h),
                    GestureDetector(
                      onTap: () {
                        showColorWheel(context, selectedColor);
                      },
                      child: Icon(
                        Icons.circle_outlined,
                        size: 15.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 5.w,
                      runSpacing: 5.h,
                      runAlignment: WrapAlignment.spaceEvenly,
                      direction: Axis.horizontal,
                      children: List.generate(
                        controller.colors.length,
                        (index) => GestureDetector(
                            onTap: () {
                              controller.onColorTap(index);
                            },
                            child: Container(
                              height: 10.sp,
                              width: 10.sp,
                              decoration: ShapeDecoration(
                                color:controller.colors[index] ,
                                shape: OvalBorder(
                                  side: BorderSide(color: Colors.black)
                                ),
                              ),

                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showColorWheel(BuildContext context, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: color,
              onColorChanged: (value) {
                color = value;
                log("Color picker $color");
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}

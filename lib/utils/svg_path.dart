import 'package:drawingtool/utils/brand_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon {
  static const String _base = 'assets/drawing_tool_icons';
  static double _h = 15.sp;
  static double _w = 15.sp;

  /// Shapes
  static SvgPicture brush = SvgPicture.asset(
    "$_base/brush.svg",
    height: _h,
    width: _w,
    color: BrandColors.shapeIconColor,
  );
  static SvgPicture circle = SvgPicture.asset(
    "$_base/circle.svg",
    height: _h,
    width: _w,
    color: BrandColors.shapeIconColor,
  );
  static SvgPicture square = SvgPicture.asset(
    "$_base/square.svg",
    height: _h,
    width: _w,
    color: BrandColors.shapeIconColor,
  );
  static SvgPicture eraser = SvgPicture.asset(
    "$_base/eraser.svg",
    height: _h,
    width: _w,
    color: BrandColors.shapeIconColor,
  );
  static SvgPicture line = SvgPicture.asset(
    "$_base/line.svg",
    height: _h,
    width: _w,
    color: BrandColors.shapeIconColor,
  );
  static SvgPicture arrow = SvgPicture.asset(
    "$_base/arrow.svg",
    height: _h,
    width: _w,
    color: BrandColors.shapeIconColor,
  );
  static SvgPicture text = SvgPicture.asset(
    "$_base/text.svg",
    height: _h,
    width: _w,
    color: BrandColors.shapeIconColor,
  );
  static SvgPicture error = SvgPicture.asset(
    "$_base/error.svg",
    height: _h,
    width: _w,
    color: BrandColors.shapeIconColor,
  );


}

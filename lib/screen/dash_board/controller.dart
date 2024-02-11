import 'package:drawingtool/utils/brand_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:ui' as ui;
import '../../utils/svg_path.dart';
import 'dart:html' as html;

class DashBoardController extends GetxController {
  late PainterController painterController;
  late Paint defaultShapePainter;
  late TextSettings defaultTextSettings;
  late FreeStyleSettings defaultFreeStyle;
  late Rx<bool> isGridVisible;

  // FocusNode textFocusNode = FocusNode();
  late Rx<int> selectedShapeBarIconIndex;
  int totalShapes = 7;
  List<Function()>? onShapeTaps;
  List<SvgPicture>? shapeSvg;

  Rx<bool> isFloatingActionVisible = false.obs;
  Rx<Widget?> floatingActionIcon = SvgIcon.error.obs;
  Function()? onTapFloatingActionButton;

  Icon fallbackIcon = const Icon(Icons.error);

  Rx<Color> selectedColor = BrandColors.brushColor.obs;
  List<Color> colors = [Colors.black, Colors.white, ...Colors.primaries];

  /// context of current screen
  late BuildContext context;

  TextEditingController nameController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController radiusController = TextEditingController();
  TextEditingController fontSizeController = TextEditingController();

  double? cw;
  double? ch;

  void onColorTap(int index) {
    selectedColor.value = colors[index];
    painterController.freeStyleColor = selectedColor.value;
    // painterController.freeStyleSettings.copyWith(color: selectedColor.value);
  }

  @override
  void onInit() {
    super.onInit();
    isGridVisible = false.obs;
    selectedShapeBarIconIndex = 3.obs;

    ///  LISTENER TO INDEX
    selectedShapeBarIconIndex.listen((value) {
      if (selectedShapeBarIconIndex.value != 1) {
        // if brush is not selected
        painterController.freeStyleMode = FreeStyleMode.none;
      }

      isFloatingActionVisible.value = true;
      onTapFloatingActionButton = onShapeTaps?[value] ?? fallBackTap;
      floatingActionIcon.value = shapeSvg?[value] ?? SvgIcon.error;
    });

    /// LIST OF ALL SHAPE TAP'S
    onShapeTaps = [
      onEraserTap,
      onBrushTap,
      onLineTap,
      onArrowTap,
      onTextTap,
      onSquareTap,
      onCircleTap
    ];

    /// LIST OF ALL SHAPE ICON'S
    shapeSvg = [
      SvgIcon.eraser,
      SvgIcon.brush,
      SvgIcon.line,
      SvgIcon.arrow,
      SvgIcon.text,
      SvgIcon.square,
      SvgIcon.circle
    ];

    initPainterController();
    // textFocusNode.addListener(onFocus);
  }

  /// INITIALIZATION OF PAINTER CONTROLLER
  void initPainterController() {
    defaultShapePainter = Paint()
      ..strokeWidth = 2
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    defaultTextSettings = TextSettings(
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: BrandColors.iconBgColor,
        fontSize: 18,
      ),
    );

    defaultFreeStyle = const FreeStyleSettings(
      color: BrandColors.brushColor,
      strokeWidth: 5,
    );

    painterController = PainterController(
        settings: PainterSettings(
      text: defaultTextSettings,
      freeStyle: defaultFreeStyle,
      shape: ShapeSettings(
        paint: defaultShapePainter,
      ),
    ));
    painterController.background = ColorBackgroundDrawable(color: Colors.white);
  }

  /// ON TAP's FOR SHAPE ICON

  /// ON TAP : ERASER
  void onEraserTap() {
    if (selectedShapeBarIconIndex.value == 0) {
      // if brush is selected
      selectedShapeBarIconIndex.value = 3;
    } else {
      // if brush is unselected
      selectedShapeBarIconIndex.value = 0;
    }
    painterController.freeStyleMode = selectedShapeBarIconIndex.value == 0
        ? FreeStyleMode.erase
        : FreeStyleMode.none;
  }

  ///  BRUSH ON TAP
  void onBrushTap() {
    selectedShapeBarIconIndex.value = 1;
    painterController.freeStyleColor = selectedColor.value;
    painterController.freeStyleMode = selectedShapeBarIconIndex.value == 1
        ? FreeStyleMode.draw
        : FreeStyleMode.none;
  }

  /// ON TAP : LINE
  void onLineTap() {
    selectedShapeBarIconIndex.value = 2;

    /// defaults
    nameController.text = "Line";
    lengthController.text = "100";
    Get.defaultDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      barrierDismissible: false,
      title: "Define Parameters",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                labelText: 'Shape Name', border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextField(
            controller: lengthController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: 'Length',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Container(
                  height: 15.sp,
                  width: 15.sp,
                  decoration: BoxDecoration(
                    color: selectedColor.value,
                    border: Border.all(color: Colors.blue, width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ))),
         SizedBox(width: 10.w),
              GestureDetector(
                onTap: () {
                  showColorPicker();
                },
                child: Icon(
                  Icons.circle_outlined,
                  size: 15.sp,
                ),
              ),
            ],
          ),
        ],
      ),
      onConfirm: () {
        selectedShapeBarIconIndex.value = 2;
        Paint linePainter = Paint()
          ..color = selectedColor.value
          ..strokeWidth = 5;

        LineDrawable customLine = LineDrawable(
            length: double.parse(lengthController.text),
            position: Offset(100, 100),
            paint: linePainter);
        painterController.insertDrawables(0, [customLine]);
        nameController.clear();
        lengthController.clear();
        selectedShapeBarIconIndex.value = 3;
        Get.back();
      },
      onCancel: () {
        selectedShapeBarIconIndex.value = 3;
      },
      buttonColor: Colors.amber,
    );
  }

  /// ON TAP : ARROW
  void onArrowTap() {
    selectedShapeBarIconIndex.value = 3;
  }

  /// ON TAP : TEXT
  void onTextTap() {
    selectedShapeBarIconIndex.value = 4;
    fontSizeController.text = '17';
    Get.defaultDialog(
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      title: "Define Parameters",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                labelText: 'Text Name', border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextField(
            controller: fontSizeController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: 'Font size',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Container(
                  height: 15.sp,
                  width: 15.sp,
                  decoration: BoxDecoration(
                    color: selectedColor.value,
                    border: Border.all(color: Colors.blue, width: 1.5.w),
                    borderRadius: BorderRadius.all(Radius.circular(5.r)),
                  ))),
            SizedBox(width: 10.w),
              GestureDetector(
                onTap: () {
                  showColorPicker();
                },
                child: const Icon(
                  Icons.circle_outlined,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
      onConfirm: () {
        double fontSize = double.parse(fontSizeController.text);
        TextSettings textSettings = TextSettings(
            textStyle: TextStyle(
          color: selectedColor.value,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ));
        painterController.textSettings = textSettings;
        painterController.addText();

        nameController.clear();
        selectedShapeBarIconIndex.value = 3;
        Get.back();
      },
      onCancel: () {
        selectedShapeBarIconIndex.value = 3;
      },
      buttonColor: Colors.amber,
    );
  }

  /// ON TAP : SQUARE
  void onSquareTap() {
    selectedShapeBarIconIndex.value = 5;

    ///  Defaults
    widthController.text = "50";
    heightController.text = "50";

    Get.defaultDialog(
      barrierDismissible: false,
      contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      title: "Define Parameters",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                labelText: 'Shape Name', border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextField(
            controller: heightController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Height',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextField(
            controller: widthController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: 'Width',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Container(
                  height: 15.h,
                  width: 15.w,
                  decoration: BoxDecoration(
                    color: selectedColor.value,
                    border: Border.all(color: Colors.blue, width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ))),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  showColorPicker();
                },
                child: Icon(
                  Icons.circle_outlined,
                  size: 15.sp,
                ),
              ),
            ],
          ),
        ],
      ),
      onConfirm: () {
        double width = double.parse(widthController.text);
        double height = double.parse(heightController.text);

        Paint squarePainter = Paint()
          ..style = PaintingStyle.stroke
          ..color = selectedColor.value
          ..strokeWidth = 5;

        RectangleDrawable rectangleDrawable = RectangleDrawable(
          size: Size(width, height),
          position: Offset(100, 100),
          paint: squarePainter,
        );
        painterController.insertDrawables(0, [rectangleDrawable]);
        nameController.clear();
        widthController.clear();
        lengthController.clear();
        selectedShapeBarIconIndex.value = 3;
        Get.back();
      },
      onCancel: () {
        selectedShapeBarIconIndex.value = 3;
      },
      buttonColor: Colors.amber,
    );
  }

  // painterController.addDrawables([rectangleDrawable]);

  /// ON TAP : CIRCLE
  void onCircleTap() {
    // if brush is unselected
    selectedShapeBarIconIndex.value = 6;

    radiusController.text = '25';

    Get.defaultDialog(
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      title: "Define Parameters",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                labelText: 'Shape Name', border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextField(
            controller: radiusController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Radius',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Container(
                  height: 15.sp,
                  width: 15.sp,
                  decoration: BoxDecoration(
                    color: selectedColor.value,
                    border: Border.all(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(5.r)),
                  ))),
              SizedBox(width: 10.h),
              GestureDetector(
                onTap: () {
                  showColorPicker();
                },
                child: Icon(
                  Icons.circle_outlined,
                  size: 15.sp,
                ),
              ),
            ],
          ),
        ],
      ),
      onConfirm: () {
        selectedShapeBarIconIndex.value = 3;

        double radius = double.parse(radiusController.text);

        Paint ovalPainter = Paint()
          ..style = PaintingStyle.stroke
          ..color = selectedColor.value
          ..strokeWidth = 5;

        OvalDrawable ovalDrawable = OvalDrawable(
            size: Size(radius * 2, radius * 2),
            position: Offset(100, 100),
            paint: ovalPainter);

        painterController.insertDrawables(0, [ovalDrawable]);
        nameController.clear();
        radiusController.clear();
        selectedShapeBarIconIndex.value = 3;
        Get.back();
      },
      onCancel: () {
        selectedShapeBarIconIndex.value = 3;
      },
      buttonColor: Colors.amber,
    );
  }

  // painterController.addDrawables([ovalDrawable]);

  /// ON TAP : FALLBACK
  void fallBackTap() {
    Get.defaultDialog(
        title: "Something went wrong. ⚠️",
        titleStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        content: const Text("Please try again later"),
        onConfirm: () {
          Get.back();
        });
  }

  void showColorPicker() {
    Get.defaultDialog(
        title: "Select Color",
        content: ColorPicker(
          pickerColor: selectedColor.value,
          onColorChanged: (value) {
            selectedColor.value = value;
          },
        ),
        onConfirm: () {
          Get.back();
        });
  }

  final GlobalKey _canvasKey = GlobalKey();

  Future<void> saveCanvas() async {
    var image = await painterController
        .renderImage(Size(cw ?? 500, ch ?? 500))
        .then((value) {
      return value.pngBytes;
    });
    final blob = html.Blob([image], 'image/png');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'my_image.png')
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}

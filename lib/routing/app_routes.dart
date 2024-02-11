import 'package:drawingtool/routing/app_route_name.dart';
import 'package:drawingtool/screen/dash_board/binding.dart';
import 'package:drawingtool/screen/dash_board/ui.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoute {



  static List<GetPage> routes = [
    GetPage(
        name: AppRouteName.home,
        page: () => DashBoardUi(),
        binding: DashBoardBinding())
  ];
}

import 'package:get/get.dart';

import '../modules/data_mengaji/bindings/data_mengaji_binding.dart';
import '../modules/data_mengaji/views/data_mengaji_view.dart';
import '../modules/data_mengaji_admin/bindings/data_mengaji_admin_binding.dart';
import '../modules/data_mengaji_admin/views/data_mengaji_admin_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/persetujuan/bindings/persetujuan_binding.dart';
import '../modules/persetujuan/views/persetujuan_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.DATA_MENGAJI,
      page: () => DataMengajiView(),
      binding: DataMengajiBinding(),
    ),
    GetPage(
      name: _Paths.DATA_MENGAJI_ADMIN,
      page: () => DataMengajiAdminView(),
      binding: DataMengajiAdminBinding(),
    ),
    GetPage(
      name: _Paths.PERSETUJUAN,
      page: () => PersetujuanView(),
      binding: PersetujuanBinding(),
    ),
  ];
}

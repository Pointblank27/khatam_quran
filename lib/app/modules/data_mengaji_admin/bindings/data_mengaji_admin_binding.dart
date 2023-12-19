import 'package:get/get.dart';

import '../controllers/data_mengaji_admin_controller.dart';

class DataMengajiAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataMengajiAdminController>(
      () => DataMengajiAdminController(),
    );
  }
}

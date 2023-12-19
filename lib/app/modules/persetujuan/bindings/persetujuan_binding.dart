import 'package:get/get.dart';

import '../controllers/persetujuan_controller.dart';

class PersetujuanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersetujuanController>(
      () => PersetujuanController(),
    );
  }
}

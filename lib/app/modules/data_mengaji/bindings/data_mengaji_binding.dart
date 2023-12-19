import 'package:get/get.dart';

import '../controllers/data_mengaji_controller.dart';

class DataMengajiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataMengajiController>(
      () => DataMengajiController(),
    );
  }
}

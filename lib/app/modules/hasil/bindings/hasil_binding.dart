import 'package:flutter_cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HasilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

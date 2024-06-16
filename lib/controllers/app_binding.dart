import 'package:get/get.dart';
import 'package:getting_started/controllers/todo_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ToDOController());
    // Get.lazyPut<ToDOController>(() => ToDOController());
  }
}

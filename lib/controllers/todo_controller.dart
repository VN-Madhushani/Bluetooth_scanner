import 'package:get/get.dart';

class ToDOController extends GetxController {
  var toDOs = ['hello', 'good morning'].obs;
  var singletoDO = 'abc'.obs;
  var tasks = <DateTime, List<String>>{}.obs;
  var selectedDay = DateTime.now().obs;

  void Add_toDo(String toDo) {
    toDOs.value.add(toDo);
  }

  void Change_todo(String toDo) {
    singletoDO.value = toDo;
  }

  // Method to add a task to a specific date
  void addTask(DateTime date, String task) {
    if (!tasks.containsKey(date)) {
      tasks[date] = <String>[].obs;
    }
    tasks[date]!.add(task);
  }
}

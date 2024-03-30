class ToDo{
  String?id;
  String?todoText;
  bool isdone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isdone=false,
    }
  );

  static  List<ToDo> todoList(){
    return [
      ToDo(id: '01', todoText: 'Cleaning',isdone: true),
      ToDo(id: '02', todoText: 'Morning exercises',isdone: true),
      ToDo(id: '03', todoText: 'Watching the tutorial',isdone: false),
      ToDo(id: '04', todoText: 'Following coursera', ),
      ToDo(id: '05', todoText: 'Talk to him',),
    ];
  }

}
import 'dart:async';

class Repository {
  final StreamController<List<ToDoModel>> _controller =
      StreamController<List<ToDoModel>>();

    final List<ToDoModel> _todos = [];

  Stream<List<ToDoModel>> get stream async*{
    yield* _controller.stream;
  }


  // Future<List<ToDoModel>> getToDos() async {
  //   final data = _controller.stream;
  //   return await data.toList();
  // }

Future<void> d()async{

}
  Future<void> createToDo(String title, String desc) async {
      final newToDo = ToDoModel(
          id: _todos.lastOrNull == null ? 0 : _todos.last.id + 1,
          title: title,
          desc: desc
      );
      _todos.add(newToDo);

      _controller.add(_todos);
  }
}

class ToDoModel {
  final int id;
  final String title;
  final String desc;

  ToDoModel({required this.id, required this.title, required this.desc});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          desc == other.desc;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ desc.hashCode;

}
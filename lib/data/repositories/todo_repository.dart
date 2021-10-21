import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/providers/todo_provider.dart';

class TodoRepository {
  final TodoProvider todoProvider;

  TodoRepository({required this.todoProvider});

  Future<List<Todo>> fetchTodos() async {
    final todosRaw = await todoProvider.getTodos();
    return todosRaw.map((e) => Todo.fromJson(e)).toList();
  }

  Future<bool> changeCompletion(bool isCompleted, int id) async {
    final patchObj = {"isCompleted": isCompleted.toString()};
    return await todoProvider.patchTodo(patchObj, id);
  }

  Future<Todo?> addTodo(String message) async {
    final todoObj = {"todo": message, "isCompleted": "false"};
    final todoMap = await todoProvider.addTodo(todoObj);
    if (todoMap == null) {
      return null;
    }
    return Todo.fromJson(todoMap);
  }

  Future<bool> deleteTodo(int id) async {
    return await todoProvider.deleteTodo(id);
  }

  Future<bool> updateTodo(String message, int id) async {
    final patchObj = {"todo": message};
    return await todoProvider.patchTodo(patchObj, id);
  }
}

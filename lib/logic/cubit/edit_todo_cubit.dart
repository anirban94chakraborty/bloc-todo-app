import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/data/models/todo.dart';

import '../../data/repositories/todo_repository.dart';
import 'todos_cubit.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final TodoRepository repository;
  final TodosCubit todosCubit;

  EditTodoCubit({required this.repository, required this.todosCubit})
      : super(EditTodoInitial());

  void deleteTodo(Todo todo) {
    repository.deleteTodo(todo.id).then((isDeleted) {
      if (isDeleted) {
        todosCubit.deleteTodo(todo);
        emit(TodoEdited());
      }
    });
  }

  void updateTodo(Todo todo, String message) {
    if (message.isEmpty) {
      emit(EditTodoError(error: "Message is empty"));
      return;
    }

    repository.updateTodo(message, todo.id).then((isEdited) {
      if (isEdited) {
        todo.todoMessage = message;
        todosCubit.updateTodoList();
        emit(TodoEdited());
      }
    });
  }
}

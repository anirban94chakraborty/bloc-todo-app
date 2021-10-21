import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/repositories/todo_repository.dart';
import 'todos_cubit.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final TodoRepository repository;
  final TodosCubit todosCubit;

  AddTodoCubit({required this.repository, required this.todosCubit})
      : super(AddTodoInitial());

  void addTodo(String message) {
    if (message.isEmpty) {
      emit(AddTodoError(error: "todo message is empty"));
      return;
    }

    emit(AddingTodo());

    Timer(const Duration(seconds: 2), () {
      repository.addTodo(message).then((todo) {
        if (todo != null) {
          todosCubit.addTodo(todo);
        }
        emit(TodoAdded());
      });
    });
  }
}

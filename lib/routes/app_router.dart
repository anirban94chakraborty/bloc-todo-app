import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/models/todo.dart';

import 'package:todo_app/logic/cubit/add_todo_cubit.dart';
import 'package:todo_app/logic/cubit/edit_todo_cubit.dart';

import '../data/providers/todo_provider.dart';
import '../data/repositories/todo_repository.dart';
import '../logic/cubit/todos_cubit.dart';
import '../presentation/screens/add_todo_screen.dart';
import '../presentation/screens/edit_todo_screen.dart';
import '../presentation/screens/todos_screen.dart';

class AppRouter {
  late TodoRepository repository;

  late TodosCubit todosCubit;

  AppRouter() {
    repository = TodoRepository(todoProvider: TodoProvider());
    todosCubit = TodosCubit(repository: repository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<TodosCubit>.value(
            value: todosCubit,
            child: const TodosScreen(),
          ),
        );
      case '/add_todo':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddTodoCubit(
              repository: repository,
              todosCubit: todosCubit,
            ),
            child: AddTodoScreen(),
          ),
        );
      case '/edit_todo':
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditTodoCubit(
              repository: repository,
              todosCubit: todosCubit,
            ),
            child: EditTodoScreen(todo: todo),
          ),
        );
      default:
        return null;
    }
  }
}

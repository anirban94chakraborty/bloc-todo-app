import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/todo.dart';
import '../../logic/cubit/todos_cubit.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/add_todo'),
            padding: const EdgeInsets.all(10),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (state is! TodosLoaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final todos = state.todos;

          return SingleChildScrollView(
            child: Column(
              children: todos.map((e) => _todo(e, context)).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _todo(Todo todo, context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        '/edit_todo',
        arguments: todo,
      ),
      child: Dismissible(
        key: Key("${todo.id}"),
        child: _todoTile(todo, context),
        background: Container(
          color: Colors.indigo,
        ),
        confirmDismiss: (_) async {
          BlocProvider.of<TodosCubit>(context).changeCompletion(todo);
          return false;
        },
      ),
    );
  }

  Widget _todoTile(Todo todo, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(todo.todoMessage),
          _completionIndicator(todo),
        ],
      ),
    );
  }

  Widget _completionIndicator(Todo todo) {
    return Container(
      width: 20.00,
      height: 20.00,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          width: 4.0,
          color: todo.isCompleted ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}

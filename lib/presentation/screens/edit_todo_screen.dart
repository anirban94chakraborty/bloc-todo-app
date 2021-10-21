import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/models/todo.dart';
import '../../logic/cubit/edit_todo_cubit.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;

  EditTodoScreen({Key? key, required this.todo}) : super(key: key);

  final _editTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _editTextController.text = todo.todoMessage;

    return BlocListener<EditTodoCubit, EditTodoState>(
      listener: (context, state) {
        if (state is TodoEdited) {
          Navigator.pop(context);
        } else if (state is EditTodoError) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Todo'),
          actions: [
            InkWell(
              onTap: () {
                BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.delete),
              ),
            )
          ],
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _editTextController,
            autocorrect: true,
            decoration: const InputDecoration(hintText: "Enter todo message"),
          ),
          const SizedBox(height: 10.0),
          InkWell(
            onTap: () {
              BlocProvider.of<EditTodoCubit>(context)
                  .updateTodo(todo, _editTextController.text);
            },
            child: _updateBtn(context),
          ),
        ],
      ),
    );
  }

  Widget _updateBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Center(
        child: Text(
          'Update Todo',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

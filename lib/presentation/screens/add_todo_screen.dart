import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../logic/cubit/add_todo_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  final TextEditingController _todoTextInputController =
      TextEditingController();

  AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Todo'),
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if (state is TodoAdded) {
            Navigator.pop(context);
          } else if (state is AddTodoError) {
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
        child: Container(
          margin: const EdgeInsets.all(20.00),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _todoTextInputController,
          decoration: const InputDecoration(hintText: "Enter todo message..."),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            final message = _todoTextInputController.text.toString();
            BlocProvider.of<AddTodoCubit>(context).addTodo(message);
          },
          child: _addBtn(context),
        )
      ],
    );
  }

  Widget _addBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            if (state is AddingTodo) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const Text(
              'Add Todo',
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}

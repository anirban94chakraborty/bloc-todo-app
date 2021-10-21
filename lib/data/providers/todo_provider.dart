import 'dart:convert';

import 'package:http/http.dart';

class TodoProvider {
  final String _baseUrl = "http://10.0.2.2:3000";

  Future<List<dynamic>> getTodos() async {
    try {
      final response = await get(Uri.parse(_baseUrl + '/todos'));
      return jsonDecode(response.body) as List;
    } catch (e) {
      return [];
    }
  }

  Future<bool> patchTodo(Map<String, String> patchObj, int id) async {
    try {
      await patch(Uri.parse(_baseUrl + "/todos/$id"), body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map> addTodo(Map<String, String> todoObj) async {
    try {
      final response =
          await post(Uri.parse(_baseUrl + '/todos'), body: todoObj);
      return jsonDecode(response.body);
    } catch (e) {
      return {};
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      await delete(Uri.parse(_baseUrl + "/todos/$id"));
      return true;
    } catch (e) {
      return false;
    }
  }
}

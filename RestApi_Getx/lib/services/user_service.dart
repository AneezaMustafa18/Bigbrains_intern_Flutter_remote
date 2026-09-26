import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserService {
  // Day 27 Node.js API
  final String baseUrl = 'http://localhost:3000';

  Future<List<UserModel>> getUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/users'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((json) => UserModel.fromJson(json))
          .toList();
    } else {
      throw Exception(
        'Failed to load users. Status code: ${response.statusCode}',
      );
    }
  }
}
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginService {
  final String apiUrl = 'http://10.0.2.2:8080/security/authenticate'; // Substitua pela sua URL

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );


    if (response.statusCode == 200) {
      debugPrint('oi${response.body}');
      return jsonDecode(response.body); // Retorna os dados se o login for bem-sucedido
    } else {
      throw Exception('Falha no login');
    }
  }
}

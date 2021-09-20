import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marchant_ambulant_gui/models/user.dart';
import 'package:marchant_ambulant_gui/config.dart';

class AuthService {
  final storage = FlutterSecureStorage();
  // Create storage
  Future<Map> login(UserCredential userCredential) async {
    final response = await http.post(Uri.parse('$BASE_URL/auth/login'), body: {
      'username': userCredential.usernameOrEmail,
      'password': userCredential.password
    });

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      // return User.fromJson(json.decode(response.body));
      setUser(response.body);
      return jsonDecode(response.body);
    } else {
      if (response.statusCode == 403) {
        Fluttertoast.showToast(
            msg: "Invalid Credentials",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
      // If that call was not successful, throw an error.
//      throw Exception(response.body);
      return jsonDecode(response.body);
    }
  }

  Future<Map> register(User user) async {
    final response =
        await http.post(Uri.parse('$BASE_URL/auth/register'), body: {
      'username': user.username,
      'password': user.password,
      'email': user.email,
      'firstname': user.firstname,
      'lastname': user.lastname,
      'phone': user.phone,
      'admin': false,
      'gender': user.gender
    });
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      // return User.fromJson(json.decode(response.body));
      return jsonDecode(response.body);
    } else {
      if (response.statusCode == 400) {
        Fluttertoast.showToast(
            msg: 'Email already exist',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
      // If that call was not successful, throw an error.
//      throw Exception(response.body);
      return jsonDecode(response.body);
    }
  }

  setUser(String value) async {
    await storage.write(key: 'user', value: value);
  }

  getUser() async {
    String user = await storage.read(key: 'user');
    if (user != null) {
      return jsonDecode(user);
    }
  }

  logout() async {
    await storage.delete(key: 'user');
  }
}

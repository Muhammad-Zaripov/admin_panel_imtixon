import 'dart:convert';

import 'package:admin_panel/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserRemoteDatasource {
  final _baseUrl =
      "https://shifoxona-2d5bd-default-rtdb.asia-southeast1.firebasedatabase.app/users";

  Future<List<UserModel>> getUsers() async {
    try {
      final url = Uri.parse("$_baseUrl.json");

      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data.isEmpty) {
          return [];
        }
        List<UserModel> users = [];
        data.forEach((key, value) {
          value["id"] = key;
          users.add(UserModel.fromJson(value));
        });
        return users;
      }
      return [];
    } catch (e, s) {
      if (kDebugMode) {
        print("xato - $e");
      }
      if (kDebugMode) {
        print("joy - $s");
      }
    }
    return [];
  }

  Future<bool> addUser(UserModel user) async {
    try {
      final url = Uri.parse("$_baseUrl.json");
      final response = await http.post(url, body: jsonEncode(user.toJson()));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Add xatolik: $e");
      }
    }
    return false;
  }

  Future<bool> updateUser(UserModel user) async {
    try {
      final url = Uri.parse("$_baseUrl/${user.id}.json");
      final response = await http.patch(url, body: jsonEncode(user.toJson()));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Update xatolik: $e");
      }
    }
    return false;
  }

  Future<bool> changePassword({
    required String userId,
    required String newPassword,
  }) async {
    try {
      final url = Uri.parse("$_baseUrl/$userId.json");

      final response = await http.patch(
        url,
        body: jsonEncode({"password": newPassword}),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Parolni yangilashda xatolik: $e");
      }
    }
    return false;
  }

  Future<UserModel?> getUserFromId(String id) async {
    try {
      final url = Uri.parse("$_baseUrl/$id.json");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        data["id"] = id;
        return UserModel.fromJson(data);
      }
      return null;
    } catch (e, s) {
      if (kDebugMode) {
        print("xato updateAppoinment - $e");
      }
      if (kDebugMode) {
        print("joy updateAppoinment - $s");
      }
    }
    return null;
  }

  Future<bool> deleteUser(String id) async {
    try {
      final url = Uri.parse("$_baseUrl/$id.json");
      final response = await http.delete(url);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("xato deleteUser - $e");
      }
      if (kDebugMode) {
        print("joy deleteUser - $s");
      }
    }
    return false;
  }
}

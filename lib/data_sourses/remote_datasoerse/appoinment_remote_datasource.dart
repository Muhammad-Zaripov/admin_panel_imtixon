import 'dart:convert';

import 'package:admin_panel/models/appoinment_models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AppoinmentRemoteDatasource {
  final _baseUrl =
      "https://shifoxona-2d5bd-default-rtdb.asia-southeast1.firebasedatabase.app/appoinments";

  Future<List<AppointmentModel>> getAppoinments() async {
    try {
      final url = Uri.parse("$_baseUrl.json");

      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data.isEmpty) {
          return [];
        }
        List<AppointmentModel> appoinments = [];
        data.forEach((key, value) {
          value["id"] = key;
          appoinments.add(AppointmentModel.fromJson(value));
        });
        return appoinments;
      }
      return [];
    } catch (e, s) {
      if (kDebugMode) {
        print("xato getAppoinment - $e");
      }
      if (kDebugMode) {
        print("joy getAppoinment Fayli - $s");
      }
    }
    return [];
  }

  Future<bool> addAppoinment(AppointmentModel appointment) async {
    try {
      final url = Uri.parse("$_baseUrl.json");

      final response = await http.post(
        url,
        body: jsonEncode(appointment.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("xato addAppoinment - $e");
      }
      if (kDebugMode) {
        print("joy addAppoinment - $s");
      }
    }
    return false;
  }

  Future<bool> updateAppoinment(AppointmentModel appointment) async {
    try {
      final url = Uri.parse("$_baseUrl/${appointment.id}.json");

      final response = await http.patch(
        url,
        body: jsonEncode(appointment.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("xato updateAppoinment - $e");
      }
      if (kDebugMode) {
        print("joy updateAppoinment - $s");
      }
    }
    return false;
  }

  Future<AppointmentModel?> getAppFromId(String id) async {
    try {
      final url = Uri.parse("$_baseUrl/$id.json");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded != null && decoded is Map<String, dynamic>) {
          decoded["id"] = id;
          return AppointmentModel.fromJson(decoded);
        } else {
          if (kDebugMode) {
            print("Response body is null or not a valid Map.");
          }
        }
      }
      return null;
    } catch (e, s) {
      if (kDebugMode) {
        print("xato updateAppoinment - $e");
        print("joy updateAppoinment - $s");
      }
      return null;
    }
  }

  Future<bool> deleteAppointment(String id) async {
    try {
      final url = Uri.parse("$_baseUrl/$id.json");
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("xato deleteAppointment - $e");
      }
      if (kDebugMode) {
        print("joy deleteAppointment - $s");
      }
    }
    return false;
  }
}

import 'dart:convert';

import 'package:admin_panel/models/doctor_models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DoctorRemoteDatasource {
  final _baseUrl =
      "https://shifoxona-2d5bd-default-rtdb.asia-southeast1.firebasedatabase.app/doctors";

  Future<List<DoctorModel>> getDoctors() async {
    try {
      final url = Uri.parse("$_baseUrl.json");

      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data.isEmpty) {
          return [];
        }
        List<DoctorModel> doctors = [];
        data.forEach((key, value) {
          value["id"] = key;
          doctors.add(DoctorModel.fromJson(value));
        });
        return doctors;
      }
      return [];
    } catch (e, s) {
      if (kDebugMode) {
        print("xato DoctorRemote - $e");
      }
      if (kDebugMode) {
        print("joy DoctorRemote Fayli - $s");
      }
    }
    return [];
  }

  Future<bool> addDoctor(DoctorModel doctor) async {
    try {
      final url = Uri.parse("$_baseUrl.json");

      final response = await http.post(url, body: jsonEncode(doctor.toJson()));

      return response.statusCode == 200;
    } catch (e, s) {
      if (kDebugMode) {
        print("xato addDoctor - $e");
      }
      if (kDebugMode) {
        print("joy addDoctor - $s");
      }
      return false;
    }
  }

  Future<bool> updateDoctor(DoctorModel doctor) async {
    try {
      final url = Uri.parse("$_baseUrl/${doctor.id}.json");

      final response = await http.patch(url, body: jsonEncode(doctor.toJson()));

      return response.statusCode == 200;
    } catch (e, s) {
      if (kDebugMode) {
        print("xato updateDoctor - $e");
      }
      if (kDebugMode) {
        print("joy updateDoctor - $s");
      }
      return false;
    }
  }

  Future<DoctorModel?> getDoctorFromId(String id) async {
    try {
      final url = Uri.parse("$_baseUrl/$id.json");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        data["id"] = id;
        return DoctorModel.fromJson(data);
      }
      return null;
    } catch (e, s) {
      if (kDebugMode) {
        print("xato getDoctorFromId - $e");
      }
      if (kDebugMode) {
        print("joy getDoctorFromId - $s");
      }
    }
    return null;
  }

  Future<bool> deleteDoctor(String id) async {
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

import 'package:flutter/material.dart';

class DoctorModel {
  String id;
  String name;
  String email;
  String description;
  int experience;
  String location;
  String locationImage;
  String speciality;
  TimeOfDay start;
  TimeOfDay end;

  DoctorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.description,
    required this.experience,
    required this.location,
    required this.locationImage,
    required this.speciality,
    required this.start,
    required this.end,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    List<String> startHour = json["start"].toString().split(":").toList();
    List<String> endHour = json["end"].toString().split(":").toList();

    return DoctorModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      description: json["description"],
      experience: json["experience"],
      location: json["location"],
      locationImage: json["locationImage"],
      speciality: json["speciality"],
      start: TimeOfDay(
        hour: int.tryParse(startHour[0]) ?? 9,
        minute: int.tryParse(startHour[1]) ?? 0,
      ),
      end: TimeOfDay(
        hour: int.tryParse(endHour[0]) ?? 9,
        minute: int.tryParse(endHour[1]) ?? 0,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    String formatTimeOfDay(TimeOfDay time) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }

    return {
      "name": name,
      "email": email,
      "description": description,
      "experience": experience,
      "location": location,
      "locationImage": locationImage,
      "speciality": speciality,
      "start": formatTimeOfDay(start),
      "end": formatTimeOfDay(end),
    };
  }
}

import 'package:flutter/material.dart';

class AppointmentModel {
  String id;
  DateTime date;
  TimeOfDay time;
  int duration;
  String notes;
  String status;
  String userId;
  String doctorId;

  AppointmentModel({
    required this.id,
    required this.date,
    required this.time,
    required this.duration,
    required this.notes,
    required this.status,
    required this.userId,
    required this.doctorId,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    List<String> timeParts = json['time'].toString().split(':');
    return AppointmentModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: int.tryParse(timeParts[0]) ?? 0,
        minute: int.tryParse(timeParts[1]) ?? 0,
      ),
      duration: json['duration'],
      notes: json['notes'],
      status: json['status'],
      userId: json['userId'],
      doctorId: json['doctorId'],
    );
  }

  Map<String, dynamic> toJson() {
    final timeStr =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return {
      'date': date.toIso8601String().split('T')[0],
      'time': timeStr,
      'duration': duration,
      'notes': notes,
      'status': status,
      'userId': userId,
      'doctorId': doctorId,
    };
  }

  AppointmentModel copyWith({
    String? id,
    DateTime? date,
    TimeOfDay? time,
    int? duration,
    String? notes,
    String? status,
    String? userId,
    String? doctorId,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      date: date ?? this.date,
      time: time ?? this.time,
      duration: duration ?? this.duration,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      doctorId: doctorId ?? this.doctorId,
    );
  }
}

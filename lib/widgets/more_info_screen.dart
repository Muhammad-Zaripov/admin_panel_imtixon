import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:admin_panel/models/appoinment_models.dart';
import 'package:admin_panel/models/doctor_models.dart';
import 'package:admin_panel/models/treatment_model.dart';
import 'package:admin_panel/models/user_model.dart';
import 'package:admin_panel/viewmodels/appointment_viewmodel.dart';
import 'package:admin_panel/viewmodels/doctor_viewmodel.dart';
import 'package:admin_panel/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';

class MoreInfoScreen extends StatefulWidget {
  final TreatmentModel treat;
  const MoreInfoScreen({super.key, required this.treat});

  @override
  State<MoreInfoScreen> createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  UserModel? user;
  DoctorModel? doctor;
  AppointmentModel? appo;
  TreatmentModel? treat;

  @override
  void initState() {
    super.initState();
    treat = widget.treat;
    appo = AppointmentViewmodel().getApFromId(treat!.appoinmentId);
    user = UserViewmodel().getApFromId(appo!.userId);
    doctor = DoctorViewmodel().getDoctorFromId(appo!.doctorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data")),
      body: Column(
        spacing: 10,
        children: [
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: ListTile(
                  title: Row(
                    spacing: 10,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(doctor!.locationImage),
                      ),
                      Text("Dr.${doctor!.name}"),
                    ],
                  ),
                  subtitle: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text("Darajasi: ${doctor!.description}."),
                      Text("Tajribasi: ${doctor!.experience} yil."),
                      Text("Mutahasisligi: ${doctor!.speciality}."),
                      Text(""),
                    ],
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: ListTile(
                  title: Text("User: ${user!.name}"),
                  subtitle: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text("Ismi: ${user!.name}."),
                      Text("Familiya: ${user!.surname}."),
                      Text("e-mail: ${user!.email}."),
                      Text("Tel: ${user!.phone}."),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 2,
            color:
                AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.3),
            endIndent: 15,
            indent: 15,
          ),
          ListTile(
            title: Text(
              "Qabul vaqti: ${appo!.date.toIso8601String().split('T')[0]}, ${appo!.time.hour.toString().padLeft(2, "0")}:${appo!.time.minute.toString().padLeft(2, "0")}",
            ),
            subtitle: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Xolati: ${appo!.status}"),
                Text("Tafsilotlar: ${appo!.notes}"),
                Text("Ko'rsatma: ${treat!.prescription}"),
                Text("Tashxis: ${treat!.diagnosis}"),
                Text("Natija: ${treat!.result}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:admin_panel/models/doctor_models.dart';
import 'package:admin_panel/viewmodels/doctor_viewmodel.dart';
import 'package:admin_panel/widgets/edit_doctor_dialog.dart';
import 'package:flutter/material.dart';

import '../widgets/add_doctor_alert_dialog.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  List<DoctorModel> docs = [];

  @override
  void initState() {
    docs = DoctorViewmodel().all;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton.filled(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddDoctorAlertDialog();
            },
          );
        },
        icon: Icon(Icons.add),
        iconSize: 35,
      ),
      appBar: AppBar(
        title: Text("Shifokorlar"),
        titleTextStyle: TextStyle(fontSize: 25, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: docs.length,
                separatorBuilder: (ctx, index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (ctx, index) {
                  final doc = docs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: ListTile(
                        subtitleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,

                          fontSize: 15,
                        ),
                        titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,

                          fontSize: 20,
                        ),
                        textColor: Colors.black,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditDoctorDialog(doctor: doc);
                            },
                          );
                          setState(() {
                            DoctorViewmodel().init();
                            docs = DoctorViewmodel().all;
                          });
                        },

                        title: Row(
                          spacing: 10,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(doc.locationImage),
                            ),
                            Text(doc.name),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              height: 2,
                              width: 200,
                            ),
                            Text("Darajasi: ${doc.description}"),
                            Text("Mutahasisligi: ${doc.speciality}"),
                            Text("Ish tajribasi: ${doc.experience} yil"),
                            Text(
                              "Ish vaqti: ${doc.start.toString()} dan ${doc.end.toString()} gacha",
                            ),
                            Text("Ish joyi: ${doc.location}"),
                          ],
                        ),
                        // trailing: Image.network(doc["locationImage"]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:admin_panel/models/appoinment_models.dart';
import 'package:admin_panel/viewmodels/appointment_viewmodel.dart';
import 'package:admin_panel/viewmodels/doctor_viewmodel.dart';
import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  List<AppointmentModel> appos = [];

  @override
  void initState() {
    appos = AppointmentViewmodel().all;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qabullar"),
        titleTextStyle: TextStyle(fontSize: 25, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: appos.length,
                separatorBuilder: (ctx, index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (ctx, index) {
                  final appo = appos[index];

                  final doctor = DoctorViewmodel().getDoctorFromId(
                    appo.doctorId,
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListTile(
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.black.withValues(alpha: 0.3),
                        ),
                      ),
                      onTap: () {
                        final dateController = TextEditingController(
                          text: appo.date.toString(),
                        );

                        final durationController = TextEditingController(
                          text: appo.duration.toString(),
                        );
                        final notesController = TextEditingController(
                          text: appo.notes,
                        );
                        final statusController = TextEditingController(
                          text: appo.status,
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: AlertDialog(
                                scrollable: true,
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "O'zgartirish kiritsh.",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              titlePadding: EdgeInsets.all(25),
                                              title: Text(
                                                "Ma'lumotlarni o'chirishni tasdiqlaysizmi?",
                                              ),
                                              content: Row(
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Yo'q"),
                                                  ),
                                                  Spacer(),
                                                  FilledButton(
                                                    onPressed: () async {
                                                      await AppointmentViewmodel()
                                                          .delete(appo.id);
                                                      setState(() {
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Text(
                                                      "Ha, tasdiqlayman!",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  Column(
                                    spacing: 15,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: dateController,
                                        decoration: InputDecoration(
                                          labelText: "Vaqt",
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1),
                                          ),
                                        ),
                                      ),

                                      TextField(
                                        controller: durationController,
                                        decoration: InputDecoration(
                                          labelText: "Muddat",
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1),
                                          ),
                                        ),
                                      ),

                                      TextField(
                                        controller: notesController,
                                        decoration: InputDecoration(
                                          labelText: "Shikoyat",
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1),
                                          ),
                                        ),
                                      ),

                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          hintText: statusController.text,
                                          hintStyle: TextStyle(
                                            color: Color(0xff9CA3AF),
                                            fontSize: 14,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        items:
                                            [
                                                  "upcoming",
                                                  "completed",
                                                  "canceled",
                                                ]
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(e),
                                                  ),
                                                )
                                                .toList(),
                                        onChanged: (value) {
                                          statusController.text = value!;
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Bekor qilish"),
                                      ),
                                      Spacer(),
                                      FilledButton(
                                        onPressed: () async {
                                          appo.date = DateTime.parse(
                                            dateController.text,
                                          );
                                          appo.duration = int.parse(
                                            durationController.text,
                                          );
                                          appo.notes = notesController.text;
                                          appo.status = statusController.text;
                                          await AppointmentViewmodel().update(
                                            appo,
                                          );
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text("O'zgartirish"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      title: Text("${appo.date}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            height: 2,
                            width: 200,
                            color: Colors.black.withValues(alpha: 0.3),
                          ),
                          Text("Doctor name: ${doctor!.name}"),
                          Text("Davomiyligi: ${appo.duration} daqiqa."),
                          Text("Ma'lumot: ${appo.notes}."),
                          Text("Xolati: ${appo.status}."),
                          Text("Vaqti: ${appo.time}"),
                        ],
                      ),
                      // trailing: appo["locationImage"],
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

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:admin_panel/models/treatment_model.dart';
import 'package:admin_panel/viewmodels/appointment_viewmodel.dart';
import 'package:admin_panel/viewmodels/doctor_viewmodel.dart';
import 'package:admin_panel/viewmodels/treatment_viewmodel.dart';
import 'package:admin_panel/viewmodels/user_viewmodel.dart';
import 'package:admin_panel/widgets/more_info_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TreatmentModel> treats = [];

  @override
  void initState() {
    treats = TreatmentViewmodel().data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin panel", style: TextStyle(fontSize: 25)),

        actions: [
          IconButton(
            onPressed: () {
              if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light) {
                AdaptiveTheme.of(context).setDark();
              } else {
                AdaptiveTheme.of(context).setLight();
              }
            },
            icon:
                (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light)
                    ? Icon(Icons.dark_mode)
                    : Icon(Icons.light_mode),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: treats.length,
                separatorBuilder: (ctx, index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (ctx, index) {
                  final treat = treats[index];
                  final appo = AppointmentViewmodel().getApFromId(
                    treat.appoinmentId,
                  );
                  UserViewmodel().getApFromId(appo!.userId);
                  DoctorViewmodel().getDoctorFromId(appo.doctorId);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoreInfoScreen(treat: treat),
                          ),
                        );
                      },
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        borderSide: BorderSide(
                          width: 2,
                          color:
                              AdaptiveTheme.of(context).mode ==
                                      AdaptiveThemeMode.light
                                  ? Colors.black.withValues(alpha: 0.3)
                                  : Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      title: Text(
                        "Qabul vaqti: ${appo.date.toIso8601String().split("T")[0]}",
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            height: 2,
                            width: 200,
                            color:
                                AdaptiveTheme.of(context).mode ==
                                        AdaptiveThemeMode.light
                                    ? Colors.black.withValues(alpha: 0.3)
                                    : Colors.white.withValues(alpha: 0.3),
                          ),
                          Text("Tashxis: ${treat.diagnosis}"),
                          Text("Shifokor ko'rsatmasi: ${treat.prescription}."),
                          Text("Xolati: ${treat.result}."),
                        ],
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

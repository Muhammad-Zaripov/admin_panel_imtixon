import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:admin_panel/views/main_screen.dart';
import 'package:admin_panel/viewmodels/appointment_viewmodel.dart';
import 'package:admin_panel/viewmodels/doctor_viewmodel.dart';
import 'package:admin_panel/viewmodels/treatment_viewmodel.dart';
import 'package:admin_panel/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserViewmodel().init();
  await DoctorViewmodel().init();
  await AppointmentViewmodel().init();
  await TreatmentViewmodel().init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.light,
      light: ThemeData(brightness: Brightness.light),
      dark: ThemeData(brightness: Brightness.dark),
      builder: (light, dark) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: light,
          darkTheme: dark,
          home: MainScreen(),
        );
      },
    );
  }
}

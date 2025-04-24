
import 'package:admin_panel/views/appointments_screen.dart';
import 'package:admin_panel/views/doctor_screen.dart';
import 'package:admin_panel/views/home_screen.dart';
import 'package:admin_panel/views/user_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

List<Widget> pages = [
  HomeScreen(),
  DoctorScreen(),
  UserScreen(),
  AppointmentsScreen(),
];
int index = 0;

class _MainScreenState extends State<MainScreen> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: pages[index],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: "Doctors",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: "Users",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information),
            label: "Appointment",
          ),
        ],
        onTap: (value) {
          index = value;
          setState(() {});
        },
      ),
    );
  }
}

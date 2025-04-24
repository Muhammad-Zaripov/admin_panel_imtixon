import 'package:admin_panel/models/doctor_models.dart';
import 'package:admin_panel/viewmodels/doctor_viewmodel.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditDoctorDialog extends StatefulWidget {
  DoctorModel doctor;
  EditDoctorDialog({super.key, required this.doctor});

  @override
  State<EditDoctorDialog> createState() => _AddDoctorAlertDialogState();
}

class _AddDoctorAlertDialogState extends State<EditDoctorDialog> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final experienceController = TextEditingController();
  final locationController = TextEditingController();
  final locationImageController = TextEditingController();
  final specialityController = TextEditingController();
  final starController = TextEditingController();
  final endController = TextEditingController();
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  final _formKey = GlobalKey<FormState>();
  String? error;
  @override
  void initState() {
    super.initState();
    nameController.text = widget.doctor.name;
    descriptionController.text = widget.doctor.description;
    experienceController.text = widget.doctor.experience.toString();
    locationController.text = widget.doctor.location;
    locationImageController.text = widget.doctor.locationImage;
    specialityController.text = widget.doctor.speciality;
    starController.text =
        "${widget.doctor.start.hour.toString().padLeft(2, "0")}:${widget.doctor.start.minute.toString().padLeft(2, "0")}";
    endController.text =
        "${widget.doctor.end.hour.toString().padLeft(2, "0")}:${widget.doctor.end.minute.toString().padLeft(2, "0")}";
    startTime = widget.doctor.start;
    endTime = widget.doctor.end;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  return value == null
                      ? "Ismingizni kiriting"
                      : value.isEmpty
                      ? "Ismingizni kiriting"
                      : null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  return value == null
                      ? "Sohani kiriting"
                      : value.isEmpty
                      ? "Sohani kiriting"
                      : null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: experienceController,
                decoration: InputDecoration(
                  hintText: "Experience",
                  hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  return value == null
                      ? "Tajribani kiriting"
                      : value.isEmpty
                      ? "Tajribani kiriting"
                      : null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: "Location",
                  hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  return value == null
                      ? "Manzilni kiriting"
                      : value.isEmpty
                      ? "Manzilni kiriting"
                      : null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return "Rasim kiriting";
                  }
                  if (value.isEmpty) {
                    return "Rasim kiriting";
                  }
                  return null;
                },
                controller: locationImageController,
                decoration: InputDecoration(
                  errorText: error,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Image",
                  hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return "Sanani kiriting";
                  }
                  if (value.isEmpty) {
                    return "Sanani kiriting";
                  }
                  return null;
                },
                controller: specialityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Speciality",
                  hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                onTap: () async {
                  startTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (startTime != null) {
                    starController.text =
                        "${startTime!.hour}:${startTime!.minute}";
                    setState(() {});
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return "Soat kiriting";
                  }
                  if (value.isEmpty) {
                    return "Soat kiriting";
                  }
                  return null;
                },
                controller: starController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Boshlash vaqti",
                  hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                onTap: () async {
                  endTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (endTime != null) {
                    endController.text = "${endTime!.hour}:${endTime!.minute}";
                    setState(() {});
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return "Soat kiriting";
                  }
                  if (value.isEmpty) {
                    return "Soat kiriting";
                  }
                  return null;
                },
                controller: endController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Tugash vaqti",
                  hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              Spacer(),
              FilledButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {});
                    if (error == null && context.mounted) {
                      DoctorModel doctor = widget.doctor;
                      doctor.name = nameController.text;
                      doctor.description = descriptionController.text;
                      doctor.experience = int.parse(experienceController.text);
                      doctor.location = locationController.text;
                      doctor.locationImage = locationImageController.text;
                      doctor.speciality = specialityController.text;
                      doctor.start = startTime!;
                      doctor.end = endTime!;
                      await DoctorViewmodel().updateDoctor(doctor);
                      if (context.mounted) {
                        setState(() {
                          Navigator.pop(context);
                        });
                      }
                    }
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

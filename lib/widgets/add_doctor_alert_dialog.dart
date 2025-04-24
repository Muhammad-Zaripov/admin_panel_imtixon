import 'package:flutter/material.dart';

import '../../../../viewmodels/user_viewmodel.dart';

class AddDoctorAlertDialog extends StatefulWidget {
  const AddDoctorAlertDialog({super.key});

  @override
  State<AddDoctorAlertDialog> createState() => _AddDoctorAlertDialogState();
}

class _AddDoctorAlertDialogState extends State<AddDoctorAlertDialog> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
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
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return "Iltimos email kiriting";
                  }
                  if (value.isEmpty) {
                    return "Iltimos email kiriting";
                  }
                  final emailRegExp = RegExp(
                    r"^[^@]+@[^@]+\.(com|uz|org|net|ru|io|edu|info|biz)$",
                  );
                  if (!emailRegExp.hasMatch(value)) {
                    return "email formati noto'g'ri";
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Email",
                  hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                ),
              ),
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
                    error =
                        await UserViewmodel().haveUser(emailController.text)
                            ? "Bunday foydalanuvchi tizimda mavjud"
                            : null;
                    setState(() {});
                    if (error == null && context.mounted) {
                      Navigator.pop(context);
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

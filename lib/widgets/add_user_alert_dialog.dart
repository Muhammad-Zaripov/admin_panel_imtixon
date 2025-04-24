import 'package:flutter/material.dart';

import '../../../../viewmodels/user_viewmodel.dart';

class AddUserAlertDialog extends StatefulWidget {
  const AddUserAlertDialog({super.key});

  @override
  State<AddUserAlertDialog> createState() => _AddUserAlertDialogState();
}

class _AddUserAlertDialogState extends State<AddUserAlertDialog> {
  final nameController = TextEditingController();
  final nickNameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final dateController = TextEditingController();
  final genderController = TextEditingController();
  DateTime? date;

  final _formKey = GlobalKey<FormState>();
  String? error;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text("Add User"),
        content: Column(
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
              controller: nickNameController,
              decoration: InputDecoration(
                hintText: "Surname",
                hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                return value == null
                    ? "Familiya kiriting"
                    : value.isEmpty
                    ? "Familiya kiriting"
                    : null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: numberController,
              decoration: InputDecoration(
                hintText: "Phono Number",
                hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                return value == null
                    ? "Nomer kiriting kiriting"
                    : value.isEmpty
                    ? "Nomer kiriting kiriting"
                    : null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                return value == null
                    ? "Parol kiriting"
                    : value.isEmpty
                    ? "Parol kiriting"
                    : value.length < 6
                    ? "Kamida 6 ta belgi"
                    : null;
              },
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
                errorText: error,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Email",
                hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              validator: (value) {
                if (value == null) {
                  return "Sanani kiriting";
                }
                return null;
              },
              readOnly: true,
              onTap: () async {
                date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1950),
                  initialDate: DateTime.now(),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  dateController.text = date!.toIso8601String();
                  setState(() {});
                }
              },
              controller: dateController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.calendar_month_rounded,
                  color: Color(0xff9CA3AF),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Date of Birth",
                hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: "Gender",
                hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items:
                  ["male", "Female"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: (value) {
                genderController.text = value!;
              },
            ),
          ],
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
                      await UserViewmodel().init();
                      if (context.mounted) {
                        Navigator.pop(context);
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

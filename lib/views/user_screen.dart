import 'package:admin_panel/models/user_model.dart';
import 'package:admin_panel/viewmodels/user_viewmodel.dart';
import 'package:admin_panel/widgets/add_user_alert_dialog.dart';
import 'package:admin_panel/widgets/edit_user_dialog.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UserModel> users = [];

  @override
  void initState() {
    users = UserViewmodel().users;
    setState(() {});
    super.initState();
  }

  void load() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton.filled(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => AddUserAlertDialog(),
          );
          users = UserViewmodel().users;
          setState(() {});
        },
        icon: Icon(Icons.add),
        iconSize: 35,
      ),
      appBar: AppBar(
        title: Text("Foydalanuvchilar"),
        titleTextStyle: TextStyle(fontSize: 25, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: users.length,
                separatorBuilder: (ctx, index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (ctx, index) {
                  final user = users[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListTile(
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.black.withValues(alpha: 0.3),
                        ),
                      ),
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EditUserDialog(user: user);
                          },
                        );
                        setState(() async {
                          await UserViewmodel().getUsers();
                          users = UserViewmodel().users;
                          setState(() {});
                        });
                      },
                      title: Text("User: ${user.name}  ${user.surname}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            height: 2,
                            width: 250,
                            color: Colors.black.withValues(alpha: 0.3),
                          ),
                          Text("Ismi: ${user.name}"),
                          Text("Familiyasi: ${user.surname}"),
                          Text("tug'ilgan sanasi: ${user.birthday}"),
                          Text("e-mail: ${user.email}"),
                          Text("Jinsi: ${user.gender}"),
                          Text("Telefon raqami: ${user.phone}"),
                          Text("password: ${user.password}"),
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

import 'package:admin_panel/models/user_model.dart';
import 'package:admin_panel/repository/user_local_repository.dart';
import 'package:admin_panel/repository/user_remote_repository.dart';

class UserViewmodel {
  static final _singleton = UserViewmodel._private();

  UserViewmodel._private();

  factory UserViewmodel() {
    return _singleton;
  }

  final userRepo = UserRemoteRepository();
  List<UserModel> users = [];

  Future<void> init() async {
    await getUsers();
  }

  Future<void> getUsers() async {
    users = await userRepo.getUser();
  }

  Future<bool> addUser(UserModel user) async {
    bool added = await userRepo.addUser(user);
    if (added) {
      await getUsers();
    }
    return added;
  }

  Future<bool> updateUser(UserModel user) async {
    final rezult = await userRepo.updateUser(user);
    if (rezult) {
      int index = users.indexWhere((element) => element.id == user.id);
      users[index] = user;
    }
    return rezult;
  }

  Future<String?> checkUser(String email, String password) async {
    if (users.isEmpty) {
      return "Tizimda foydalanuvchilar yo'q";
    }
    for (var element in users) {
      if (element.email.toLowerCase() == email.toLowerCase()) {
        if (element.password == password) {
          UserLocalRepository userLocalRepository = UserLocalRepository();
          await userLocalRepository.setUser(element);
          return null;
        }
        return "Parol xato";
      }
    }

    return "Bunday foydalanuvchi tizimda mavjud emas";
  }

  Future<bool> haveUser(String email) async {
    if (users.isEmpty) {
      return false;
    }
    for (var element in users) {
      if (element.email.toLowerCase() == email.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  Future<bool> changePassword({
    required String newPassword,
    required String email,
  }) async {
    String? userId;
    for (var element in users) {
      if (element.email.toLowerCase() == email.toLowerCase()) {
        userId = element.id;
        element.password = newPassword;
      }
    }
    if (userId == null) {
      return false;
    }
    return await userRepo.changePassword(
      userId: userId,
      newPassword: newPassword,
    );
  }

  UserModel? getApFromId(String id) {
    final index = users.indexWhere((e) => e.id == id);
    if (index != -1) {
      return users[index];
    }
    userRepo.getUserFromId(id).then((value) {
      return value;
    });
    return null;
  }

  Future<bool> delete(String id) async {
    final index = users.indexWhere((e) => e.id == id);
    if (index == -1) return false;

    final success = await userRepo.deleteUser(id);
    if (success) {
      users.removeAt(index);
    }

    return success;
  }
}

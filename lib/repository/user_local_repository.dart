import 'package:admin_panel/data_sourses/local_datasourse/user_local_datasource.dart';
import 'package:admin_panel/models/user_model.dart';

class UserLocalRepository {
  final UserLocalDatasource userLocal = UserLocalDatasource();

  Future<void> setUser(UserModel user) async {
    userLocal.setUser(user);
  }

  Future<UserModel?> getUser() async {
    return userLocal.getUser();
  }

  Future<bool> clear() async {
    return userLocal.clear();
  }
  
}

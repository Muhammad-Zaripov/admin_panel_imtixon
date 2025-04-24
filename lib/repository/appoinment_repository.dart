import 'package:admin_panel/data_sourses/remote_datasoerse/appoinment_remote_datasource.dart';
import 'package:admin_panel/models/appoinment_models.dart';

class AppoinmentRepository {
  final AppoinmentRemoteDatasource appoRemote = AppoinmentRemoteDatasource();

  Future<List<AppointmentModel>> getAppoinments() async {
    return appoRemote.getAppoinments();
  }

  Future<bool> addAppoinment(AppointmentModel data) async {
    return appoRemote.addAppoinment(data);
  }

  Future<bool> updateAppoinment(AppointmentModel data) async {
    return appoRemote.updateAppoinment(data);
  }

  Future<AppointmentModel?> getAppFromId(String id) async {
    return appoRemote.getAppFromId(id);
  }

  Future<bool> deleteAppoinment(String id) async {
    return appoRemote.deleteAppointment(id);
  }
}

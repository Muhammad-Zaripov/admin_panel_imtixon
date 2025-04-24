import 'package:admin_panel/data_sourses/remote_datasoerse/doctor_remote_datasource.dart';
import 'package:admin_panel/models/doctor_models.dart';

class DoctorRepository {
  final DoctorRemoteDatasource doctorRemote = DoctorRemoteDatasource();

  Future<List<DoctorModel>> getDoctors() async {
    return doctorRemote.getDoctors();
  }

  Future<bool> addDoctor(DoctorModel doctor) async {
    return doctorRemote.addDoctor(doctor);
  }

  Future<bool> updateDoctor(DoctorModel doctor) async {
    return doctorRemote.updateDoctor(doctor);
  }

  Future<DoctorModel?> getDoctorFromId(String id) async {
    return doctorRemote.getDoctorFromId(id);
  }

  Future<bool> deleteAppoinment(String id) async {
    return doctorRemote.deleteDoctor(id);
  }
}

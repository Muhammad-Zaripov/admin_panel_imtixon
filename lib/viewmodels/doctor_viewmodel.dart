import 'package:admin_panel/models/doctor_models.dart';
import 'package:admin_panel/repository/doctor_repository.dart';

class DoctorViewmodel {
  static final _singleton = DoctorViewmodel._private();

  DoctorViewmodel._private();

  factory DoctorViewmodel() {
    return _singleton;
  }

  List<DoctorModel> doctors = [];
  DoctorRepository doctorRepo = DoctorRepository();

  Future<void> init() async {
    doctors = await doctorRepo.getDoctors();
  }

  Future<void> refresh() async {
    await init();
  }

  Future<bool> add(DoctorModel model) async {
    final success = await doctorRepo.addDoctor(model);
    if (success) {
      await refresh();
    }
    return success;
  }

  Future<bool> updateDoctor(DoctorModel doctor) async {
    bool status = await doctorRepo.updateDoctor(doctor);
    if (status) {
      final index = doctors.indexWhere((e) => e.id == doctor.id);
      doctors[index] = doctor;
    }
    return status;
  }

  List<DoctorModel> get all => doctors;

  DoctorModel? getDoctorFromId(String id) {
    final index = doctors.indexWhere((e) => e.id == id);
    if (index != -1) {
      return doctors[index];
    }
    doctorRepo.getDoctorFromId(id).then((value) {
      return value;
    });
    return null;
  }

  bool haveDoctor(String email) {
    for (var element in doctors) {
      if (element.email.toLowerCase() == email.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  Future<bool> delete(String id) async {
    final index = doctors.indexWhere((e) => e.id == id);
    if (index == -1) return false;

    final success = await doctorRepo.deleteAppoinment(id);
    if (success) {
      doctors.removeAt(index);
    }

    return success;
  }
}

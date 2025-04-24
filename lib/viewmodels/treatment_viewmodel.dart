import 'package:admin_panel/models/treatment_model.dart';
import 'package:admin_panel/repository/treatment_repository.dart';

class TreatmentViewmodel {
  static final _singleton = TreatmentViewmodel._private();

  TreatmentViewmodel._private();

  factory TreatmentViewmodel() {
    return _singleton;
  }

  List<TreatmentModel> data = [];

  TreatmentRepository repo = TreatmentRepository();

  Future<void> init() async {
    data = await repo.getTreatments();
  }

  Future<bool> addTreatment(TreatmentModel tr) async {
    return repo.updateTreatment(tr);
  }

  Future<bool> update(TreatmentModel tr) async {
    final rezult = await repo.updateTreatment(tr);

    if (rezult) {
      int index = data.indexWhere((element) => element.id == tr.id);
      data[index] = tr;
    }
    return rezult;
  }
}

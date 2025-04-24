import 'package:admin_panel/data_sourses/remote_datasoerse/treatment_remote_datasource.dart';
import 'package:admin_panel/models/treatment_model.dart';

class TreatmentRepository {
  final TreatmentRemoteDatasource treatmentRemote = TreatmentRemoteDatasource();

  Future<List<TreatmentModel>> getTreatments() async {
    return treatmentRemote.getData();
  }

  Future<bool> addTreatment(TreatmentModel data) async {
    return treatmentRemote.addTreatment(data);
  }

  Future<bool> updateTreatment(TreatmentModel data) async {
    return treatmentRemote.updateTreatment(data);
  }

  Future<TreatmentModel?> getTrFromId(String id) async {
    return treatmentRemote.getTrFromId(id);
  }
}

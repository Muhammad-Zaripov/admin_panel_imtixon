class TreatmentModel {
  String id;
  String appoinmentId;
  String diagnosis;
  String prescription;
  String result;

  TreatmentModel({
    required this.id,
    required this.appoinmentId,
    required this.diagnosis,
    required this.prescription,
    required this.result,
  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) {
    return TreatmentModel(
      id: json['id'],
      appoinmentId: json['appoinmentid'],
      diagnosis: json['diagnosis'],
      prescription: json['prescription'],
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appoinmentid': appoinmentId,
      'diagnosis': diagnosis,
      'prescription': prescription,
      'result': result,
    };
  }
}

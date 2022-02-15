class RentModel {
  final DateTime startDate;
  final DateTime endDate;
  final String refDocumentCar;
  final String userUid;
  RentModel({
    required this.startDate,
    required this.endDate,
    required this.refDocumentCar,
    required this.userUid,
  });
}

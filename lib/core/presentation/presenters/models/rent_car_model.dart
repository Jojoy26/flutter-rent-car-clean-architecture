import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/entities/rent_model.dart';

class RentCarModel {
  final RentModel rentModel;
  final CarModel carModel;
  RentCarModel({
    required this.rentModel,
    required this.carModel,
  });
}

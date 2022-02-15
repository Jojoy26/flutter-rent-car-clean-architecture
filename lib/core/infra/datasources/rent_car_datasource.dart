import 'package:flutter_rent/core/domain/usecases/rent_car.dart';

abstract class RentCarDatasource {
  Future<String> rentCar(RentCarParams params);
}
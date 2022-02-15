import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/errors/rentCarException/errors.dart';
import 'package:flutter_rent/core/domain/usecases/rent_car.dart';

abstract class RentCarRepository {
  Future<Either<RentCarException, String>> rentCar(RentCarParams params);
}
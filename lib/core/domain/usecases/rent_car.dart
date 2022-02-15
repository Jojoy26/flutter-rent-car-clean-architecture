import 'package:dartz/dartz.dart';

import 'package:flutter_rent/core/domain/errors/rentCarException/errors.dart';
import 'package:flutter_rent/core/domain/repository/rent_car_repository.dart';

abstract class RentCar {
  Future<Either<RentCarException, String>> call(RentCarParams params);
}

class RentCarImpl implements RentCar {

  final RentCarRepository repository;
  RentCarImpl({
    required this.repository,
  });

  @override
  Future<Either<RentCarException, String>> call(RentCarParams params) async {
    return await repository.rentCar(params);
  }
}

class RentCarParams {
  final DateTime startDate;
  final DateTime endDate;
  final String refDocumentCar;
  final String userUid;
  RentCarParams({
    required this.startDate,
    required this.endDate,
    required this.refDocumentCar,
    required this.userUid,
  });
  
}

import 'package:dartz/dartz.dart';

import 'package:flutter_rent/core/domain/entities/rent_model.dart';
import 'package:flutter_rent/core/domain/errors/getUserRentCars/erros.dart';
import 'package:flutter_rent/core/domain/repository/get_repository.dart';

abstract class GetUserRentCars {
  Future<Either<GetUserRentCarsException, List<RentModel>>> call(String userUid);
}

class GetUserRentCarsImpl implements GetUserRentCars {

  final GetRepository repository;
  GetUserRentCarsImpl({
    required this.repository,
  });

  @override
  Future<Either<GetUserRentCarsException, List<RentModel>>> call(String userUid) async {
    return await repository.getUserRentCars(userUid);
  }
}

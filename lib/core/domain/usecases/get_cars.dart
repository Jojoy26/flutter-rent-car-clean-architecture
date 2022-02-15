import 'package:dartz/dartz.dart';

import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/errors/getCars/erros.dart';
import 'package:flutter_rent/core/domain/repository/get_repository.dart';

abstract class GetCars{
  Future<Either<GetCarsException, List<CarModel>>> call();
}

class GetCarsImpl implements GetCars {

  final GetRepository repository;
  GetCarsImpl({
    required this.repository,
  });

  @override
  Future<Either<GetCarsException, List<CarModel>>> call() async {
    return await repository.getCars();
  }
}

import 'package:dartz/dartz.dart';

import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/errors/getCarByRef/erros.dart';
import 'package:flutter_rent/core/domain/repository/get_repository.dart';

abstract class GetCarByRef {
  Future<Either<GetCarByRefException, CarModel>> call(String carRef);
}

class GetCarByRefImpl implements GetCarByRef {

  final GetRepository repository;
  GetCarByRefImpl({
    required this.repository,
  });
  
  @override
  Future<Either<GetCarByRefException, CarModel>> call(String carRef) async {
    return await repository.getCarByRef(carRef);
  }

}

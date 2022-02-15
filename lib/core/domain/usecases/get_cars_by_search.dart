import 'package:dartz/dartz.dart';

import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/errors/getCarsBySearch/erros.dart';
import 'package:flutter_rent/core/domain/repository/get_repository.dart';

abstract class GetCarsBySearch {
  Future<Either<GetCarsBySearchException, List<CarModel>>> call(String search);
}

class GetCarsBySearchImpl implements GetCarsBySearch {

  final GetRepository repository;
  GetCarsBySearchImpl({
    required this.repository,
  });

  @override
  Future<Either<GetCarsBySearchException, List<CarModel>>> call(String search) async {
    return await repository.getCarsBySearch(search);
  }
}

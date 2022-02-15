import 'package:dartz/dartz.dart';

import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/errors/getCarsByBrand/errors.dart';
import 'package:flutter_rent/core/domain/repository/get_repository.dart';

abstract class GetCarsByBrand {
  Future<Either<GetCarsByBrandException, List<CarModel>>> call(String brandName);
}

class GetCarsByBrandImpl implements GetCarsByBrand {

  final GetRepository repository;
  GetCarsByBrandImpl({
    required this.repository,
  });

  Future<Either<GetCarsByBrandException, List<CarModel>>> call(String brandName) async{
    return await repository.getCarsByBrand(brandName);
  }
}

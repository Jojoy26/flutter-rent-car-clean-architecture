import 'package:dartz/dartz.dart';

import 'package:flutter_rent/commons/networkInfo/network_info.dart';
import 'package:flutter_rent/core/domain/errors/rentCarException/errors.dart';
import 'package:flutter_rent/core/domain/repository/rent_car_repository.dart';
import 'package:flutter_rent/core/domain/usecases/rent_car.dart';
import 'package:flutter_rent/core/infra/datasources/rent_car_datasource.dart';

class RentCarRepositoryImpl implements RentCarRepository {

  final RentCarDatasource datasource;
  final NetworkInfo netInfo;
  RentCarRepositoryImpl({
    required this.datasource,
    required this.netInfo,
  });

  @override
  Future<Either<RentCarException, String>> rentCar(RentCarParams params) async {
    if(await netInfo.isConnected()){
      try {
        final result = await datasource.rentCar(params);
        return Right(result);
      } catch(e){
        return Left(FailureRentCar());
      }
    }
    return Left(NoInternetConnectionRentCar());
  }
}

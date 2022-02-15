import 'package:dartz/dartz.dart';

import 'package:flutter_rent/commons/networkInfo/network_info.dart';
import 'package:flutter_rent/core/domain/entities/brand_model.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/entities/rent_model.dart';
import 'package:flutter_rent/core/domain/errors/getBrands/erros.dart';
import 'package:flutter_rent/core/domain/errors/getCarByRef/erros.dart';
import 'package:flutter_rent/core/domain/errors/getCars/erros.dart';
import 'package:flutter_rent/core/domain/errors/getCarsByBrand/errors.dart';
import 'package:flutter_rent/core/domain/errors/getCarsBySearch/erros.dart';
import 'package:flutter_rent/core/domain/errors/getUserRentCars/erros.dart';

import 'package:flutter_rent/core/domain/repository/get_repository.dart';
import 'package:flutter_rent/core/infra/datasources/get_datasource.dart';

class GetRepositoryImpl implements GetRepository {

  final NetworkInfo netInfo;
  final GetDatasource datasource;
  GetRepositoryImpl({
    required this.netInfo,
    required this.datasource,
  });

  @override
  Future<Either<GetBrandsException, List<BrandModel>>> getBrands() async{
    if(await netInfo.isConnected()) {
      try {
        final result =  await datasource.getBrands();
        return Right(result);
      } catch (e){
        return Left(FailureGetBrands());
      }
    }
    return Left(NoInternetConnectionGetBrands());
  }

  @override
  Future<Either<GetCarsException, List<CarModel>>> getCars() async {
    if(await netInfo.isConnected()) { 
      try {
        final result = await datasource.getCars();
        return Right(result);
      } catch (e){
        return Left(FailureGetCars());
      }
    }
    return Left(NoInternetConnectionGetCars());
  }

  @override
  Future<Either<GetCarsByBrandException, List<CarModel>>> getCarsByBrand(String brandName) async {
    if(await netInfo.isConnected()) {
      try {
        final result = await datasource.getCarsByBrand(brandName);
        return Right(result);
      } catch (e) {
        return Left(FailureGetCarsByBrand());
      }
    }
    return Left(NoInternetConnectionGetCarsByBrand());
  }

  @override
  Future<Either<GetCarsBySearchException, List<CarModel>>> getCarsBySearch(String search) async{
    if(await netInfo.isConnected()) {
      try {
        final result = await datasource.getCarsBySearch(search);
        return Right(result);
      } catch (e) {
        return Left(FailureGetCarsBySearch());
      }
    }
    return Left(NoInternetConnectionGetCarsBySearch());
  }

  @override
  Future<Either<GetCarByRefException, CarModel>> getCarByRef(String carRef) async {
    if(await netInfo.isConnected()){
      try {
        final result = await datasource.getCarByRef(carRef);
        return Right(result);
      } catch (e) {
        return Left(FailureGetCarByRef());
      }
    }
    return Left(NoInternetConnectionGetCarByRef());
  }

  @override
  Future<Either<GetUserRentCarsException, List<RentModel>>> getUserRentCars(String userUid) async {
    if(await netInfo.isConnected()){
      try {
        final result = await datasource.getUserRentCars(userUid);
        return Right(result);
      } catch(e){
        return Left(FailureGetUserRentCars());
      }
    }
    return Left(NoInternetConnectionGetUserRentCars());
  }
}

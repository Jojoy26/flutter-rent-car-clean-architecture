import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/brand_model.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/entities/rent_model.dart';
import 'package:flutter_rent/core/domain/errors/getBrands/erros.dart';
import 'package:flutter_rent/core/domain/errors/getCarByRef/erros.dart';
import 'package:flutter_rent/core/domain/errors/getCars/erros.dart';
import 'package:flutter_rent/core/domain/errors/getCarsByBrand/errors.dart';
import 'package:flutter_rent/core/domain/errors/getCarsBySearch/erros.dart';
import 'package:flutter_rent/core/domain/errors/getUserRentCars/erros.dart';



abstract class GetRepository {
  Future<Either<GetBrandsException, List<BrandModel>>> getBrands();
  Future<Either<GetCarsException, List<CarModel>>> getCars();
  Future<Either<GetCarsByBrandException, List<CarModel>>> getCarsByBrand(String brandName);
  Future<Either<GetCarsBySearchException, List<CarModel>>> getCarsBySearch(String search);
  Future<Either<GetCarByRefException, CarModel>> getCarByRef(String carRef);
  Future<Either<GetUserRentCarsException, List<RentModel>>> getUserRentCars(String userUid);
}
import 'package:flutter_rent/core/domain/entities/brand_model.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/entities/rent_model.dart';

abstract class GetDatasource {
  Future<List<BrandModel>> getBrands();
  Future<List<CarModel>> getCars();
  Future<List<CarModel>> getCarsByBrand(String brandName);
  Future<List<CarModel>> getCarsBySearch(String search);
  Future<CarModel> getCarByRef(String carRef);
  Future<List<RentModel>> getUserRentCars(String userUid);
}
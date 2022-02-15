import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rent/core/domain/entities/brand_model.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/entities/rent_model.dart';
import 'package:flutter_rent/core/external/firebaseGet/mapper.dart';
import 'package:flutter_rent/core/infra/datasources/get_datasource.dart';

class FirebaseGetDatasourceImpl implements GetDatasource {

  @override
  Future<List<BrandModel>> getBrands() async {
    CollectionReference brands = FirebaseFirestore.instance.collection("brands");
    try {
      final result = await brands.get();
      final listBrands = <BrandModel>[];
      for(QueryDocumentSnapshot item in result.docs){
        listBrands.add(BrandModelMapper.fromJson(item));
      }
      return listBrands;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<CarModel>> getCars() async {
    CollectionReference cars = FirebaseFirestore.instance.collection("cars");
    try {
      final result = await cars.get();
      print("Não morreu");
      final listCars = <CarModel>[];
      for(QueryDocumentSnapshot item in result.docs){
        listCars.add(CarModelMapper.fromJson(item));
      }
      return listCars;
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<List<CarModel>> getCarsByBrand(String brandName) async {
    CollectionReference cars = FirebaseFirestore.instance.collection("cars");
    try {
      final result = await cars.where(
        "brand", isEqualTo: brandName
      ).get();
      final listCars = <CarModel>[];
      for(QueryDocumentSnapshot item in result.docs){
        listCars.add(CarModelMapper.fromJson(item));
      }
      return listCars;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<CarModel>> getCarsBySearch(String search) async {
    CollectionReference cars = FirebaseFirestore.instance.collection("cars");
    try {
      final result = await cars.where("carName", isGreaterThanOrEqualTo: search).get();
      final listCars = <CarModel>[];
      for(QueryDocumentSnapshot item in result.docs){
        listCars.add(CarModelMapper.fromJson(item));
      }
      return listCars;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<CarModel> getCarByRef(String carRef) async {
    CollectionReference cars = FirebaseFirestore.instance.collection("cars");
    try {
      final result = await cars.doc(carRef).get();
      return CarModelMapper.fromJson(result);
    } catch(e){
      throw Exception();
    }
  }

  @override
  Future<List<RentModel>> getUserRentCars(String userUid) async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    try {
      final result = await users.doc(userUid).collection("rents").get();
      final listRentModel = <RentModel>[];

      for(QueryDocumentSnapshot item in result.docs){
        print("Indo aqui");
        listRentModel.add(RentModelMapper.fromJson(item));
      }

      return listRentModel;
    } catch(e){
      print(e);
      throw Exception();
    }
  }

}
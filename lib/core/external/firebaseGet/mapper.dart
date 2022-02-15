import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_rent/core/domain/entities/brand_model.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/entities/rent_model.dart';


class BrandModelMapper {
  static BrandModel fromJson (QueryDocumentSnapshot data) {
    final dataCopy = data.data() as Map<String, dynamic>;
    return BrandModel(
      refDocument: data.reference.id, 
      img: dataCopy["img"], 
      brand: dataCopy["brand"]
    );
  }
}

class CarModelMapper {
  static CarModel fromJson (DocumentSnapshot data) {
    final dataCopy = data.data() as Map<String, dynamic>;
    return CarModel(
      refDocument: data.reference.id, 
      carName: dataCopy["carName"],
      brand: dataCopy["brand"], 
      img: dataCopy["img"], 
      price: dataCopy["price"], 
      rentBy: dataCopy["rentBy"], 
      reviewsNumber: dataCopy["reviewsNumber"], 
      score: dataCopy["score"], 
      locationCar: dataCopy["locationCar"], 
      description: dataCopy["description"], 
      specifications: dataCopy["specifications"]
    );
  }
}

class RentModelMapper {
  static RentModel fromJson (DocumentSnapshot data) {
    final dataCopy = data.data() as Map<String, dynamic>;
    return RentModel(
      startDate: DateTime.fromMicrosecondsSinceEpoch(dataCopy["startDate"].microsecondsSinceEpoch),
      endDate: DateTime.fromMicrosecondsSinceEpoch(dataCopy["endDate"].microsecondsSinceEpoch),
      refDocumentCar: dataCopy["refDocumentCar"],
      userUid: dataCopy["userUid"]
    );
  }
}



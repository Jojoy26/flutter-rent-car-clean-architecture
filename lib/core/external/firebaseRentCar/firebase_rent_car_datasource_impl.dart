import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rent/core/domain/usecases/rent_car.dart';
import 'package:flutter_rent/core/infra/datasources/rent_car_datasource.dart';

class FirebaseRentCarDatasourceImpl implements RentCarDatasource{

  @override
  Future<String> rentCar(RentCarParams params) async {

    CollectionReference usersReferece = FirebaseFirestore.instance.collection("users");
    try {
      final result = await usersReferece.doc(params.userUid).collection("rents").add({
        "startDate": params.startDate,
        "endDate": params.endDate,
        "refDocumentCar": params.refDocumentCar,
        "userUid": params.userUid
      });
      return result.id;

    } catch(e){
      throw Exception();
    }
    
  }
}
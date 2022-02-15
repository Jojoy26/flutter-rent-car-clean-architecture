import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/usecases/login_by_email.dart';
import 'package:flutter_rent/core/domain/usecases/rent_car.dart';
import 'package:flutter_rent/core/domain/usecases/singup_by_email.dart';

final credentialParamsSingUpTest = CredentialParamsSingUp(email: "joy@gmail.com", password: "12675457", name: "Fred", phoneNumber: "32946556455");
final loggedUserTest = LoggedUser(name: "Fred", email: "joy@gmail.com", phoneNumber: "32946556455", uid: "FGGSAOFSA54G6ASG");
final credentialParamsLoginTest = CredentialParamsLogin(email: "joy@gmail.com", password: "12675457");
String brandNameTest = "bmw";
String searchTest = "bmw";
final listTest = ["gasgsa", "gasg"];
final rentCarParamsTest = RentCarParams(startDate: DateTime.now(), endDate: DateTime.now(), refDocumentCar: "", userUid: "");
String stringReturnedOfRentcarTest = "fGHA986H98HGKK97KFJ4WSDGG";
String carModelRefTest = "vkN6c2toHlzVQBpGwqal";
final carModelTest = CarModel(
  carName: "", 
  refDocument: "",
  brand: "", 
  img: "", 
  price: 360, 
  rentBy: "", 
  reviewsNumber: 126, 
  score: 4.6, 
  locationCar: "", 
  description: "", 
  specifications: []
);
String userUidParamsTest = "gasgasgqwgqh";
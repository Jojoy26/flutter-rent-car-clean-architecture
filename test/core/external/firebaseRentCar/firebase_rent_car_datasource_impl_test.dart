import 'package:flutter_rent/core/external/firebaseRentCar/firebase_rent_car_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';


class MockFirebaseRentCarDatasourceImpl extends Mock implements FirebaseRentCarDatasourceImpl{}
void main() {

  final datasource = MockFirebaseRentCarDatasourceImpl();
  testWidgets('Must complete', (tester) async {
    when(() => datasource.rentCar(rentCarParamsTest)).thenAnswer((invocation) => Future.value(stringReturnedOfRentcarTest));

    final result = datasource.rentCar(rentCarParamsTest);
    expect(result, completes);
  });
}
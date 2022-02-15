import 'package:flutter_rent/core/external/localFavorites/local_favorites_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';


class MockLocalFavoritesDatasourceImpl extends Mock implements LocalFavoritesDatasourceImpl{}
void main() {

  final datasource = MockLocalFavoritesDatasourceImpl();
  
  testWidgets('Must complete getFavorites', (tester) async {
    when(() => datasource.getFavorites()).thenAnswer((invocation) => Future.value(<String>[]));

    final result = await datasource.getFavorites();

    expect(result, isA<List<String>>());
  });
  testWidgets('Must complete saveFavorites', (tester) async {
    when(() => datasource.saveFavorites(listTest)).thenAnswer((invocation) => Future.value(<String>[]));

    final result = await datasource.saveFavorites(listTest);

    expect(result, isA<List<String>>());
  });
}
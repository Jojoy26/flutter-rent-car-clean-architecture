import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/brand_model.dart';
import 'package:flutter_rent/core/domain/errors/getBrands/erros.dart';
import 'package:flutter_rent/core/domain/usecases/get_brands.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/categories_repository_mock.dart';



void main() {

  final repository = MockGetRepository();
  final usecase = GetBrandsImpl(repository: repository);
  testWidgets('Must return a List of brandModel', (tester) async {
    when(() => repository.getBrands()).thenAnswer((realInvocation) => Future.value(Right(<BrandModel>[])));

    final result = await usecase();
    expect(result.fold(id, id), isA<List<BrandModel>>());
  });

  testWidgets('Must return a FailureGetBrands', (tester) async {
    when(() => repository.getBrands()).thenAnswer((realInvocation) => Future.value(Left(FailureGetBrands())));

    final result = await usecase();
    expect(result.fold(id, id), isA<FailureGetBrands>());
  });
}
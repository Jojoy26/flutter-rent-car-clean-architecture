import 'package:dartz/dartz.dart';

import 'package:flutter_rent/core/domain/entities/brand_model.dart';
import 'package:flutter_rent/core/domain/errors/getBrands/erros.dart';
import 'package:flutter_rent/core/domain/repository/get_repository.dart';



abstract class GetBrands {
  Future<Either<GetBrandsException, List<BrandModel>>> call();
}

class GetBrandsImpl extends GetBrands {

  final GetRepository repository;
  GetBrandsImpl({
    required this.repository,
  });

  @override
  Future<Either<GetBrandsException, List<BrandModel>>> call() async {
    return await repository.getBrands();
  }

}

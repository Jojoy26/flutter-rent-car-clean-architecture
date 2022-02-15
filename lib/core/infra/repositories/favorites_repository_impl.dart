import 'package:dartz/dartz.dart';

import 'package:flutter_rent/core/domain/errors/favoritesErrors/erros.dart';
import 'package:flutter_rent/core/domain/repository/favorites_repository.dart';
import 'package:flutter_rent/core/infra/datasources/favorites_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {

  final FavoritesDatasource datasource;
  FavoritesRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<FavoritesException, List<String>>> getFavorites() async {
    try {
      final result = await datasource.getFavorites();
      return Right(result);
    } catch (e) {
      return Left(FailureGetFavorites());
    }
  }

  @override
  Future<Either<FavoritesException, List<String>>> saveFavorites(List<String> list) async {
    try {
      final result = await datasource.saveFavorites(list);
      return Right(result);
    } catch (e) {
      return Left(FailureSaveFavorites());
    }
  }
}

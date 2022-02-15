import 'package:dartz/dartz.dart';

import 'package:flutter_rent/core/domain/errors/favoritesErrors/erros.dart';
import 'package:flutter_rent/core/domain/repository/favorites_repository.dart';

abstract class GetFavorites {
  Future<Either<FavoritesException, List<String>>> call();
}

class GetFavoritesImpl implements GetFavorites {

  final FavoritesRepository repository;
  GetFavoritesImpl({
    required this.repository,
  });

  @override
  Future<Either<FavoritesException, List<String>>> call() async {
    return await repository.getFavorites();
  }
}

import 'package:dartz/dartz.dart';

import 'package:flutter_rent/core/domain/errors/favoritesErrors/erros.dart';
import 'package:flutter_rent/core/domain/repository/favorites_repository.dart';

abstract class SaveFavorites {
  Future<Either<FavoritesException, List<String>>> call(List<String> list);
}

class SaveFavoritesImpl implements SaveFavorites {

  final FavoritesRepository repository;
  SaveFavoritesImpl({
    required this.repository,
  });

  @override
  Future<Either<FavoritesException, List<String>>> call(List<String> list) async {
    return await repository.saveFavorites(list);
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/errors/favoritesErrors/erros.dart';

abstract class FavoritesRepository {
  Future<Either<FavoritesException, List<String>>> getFavorites ();
  Future<Either<FavoritesException, List<String>>> saveFavorites (List<String> list);
}
import '../../models/movie_model.dart';

abstract class ILocalStorage {
  Future<List<MovieModel>> getFavoriteMovies();
  Future<void> setFavoriteMovies(List<MovieModel> favoriteMoviesList);
}

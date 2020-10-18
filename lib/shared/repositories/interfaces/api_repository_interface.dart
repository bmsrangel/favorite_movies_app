import '../../models/movie_model.dart';

abstract class IApiRepository {
  Future<List<MovieModel>> getAllMovies();
}

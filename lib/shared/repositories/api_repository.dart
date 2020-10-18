import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../exceptions/rest_exception.dart';
import '../models/movie_model.dart';
import 'interfaces/api_repository_interface.dart';

class ApiRepository implements IApiRepository {
  final Dio _dioClient;

  ApiRepository(this._dioClient);

  @override
  Future<List<MovieModel>> getAllMovies() async {
    try {
      final Response response = await this._dioClient.get("/filmes");
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> moviesMapList =
            List<Map<String, dynamic>>.from(response.data["filmes"] as List);
        return moviesMapList
            .map((movieMap) => MovieModel.fromMap(movieMap))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw RestException(
          "Ops... Parece que algo deu errado! Verifique sua conexão com a internet e tente novamente!");
    }
  }
}

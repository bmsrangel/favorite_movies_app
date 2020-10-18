import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/blocs/favorite_movie_list_bloc.dart';
import '../../../shared/models/movie_model.dart';
import '../widgets/favorite_movie_card_widget.dart';

class FavoritesScreen extends StatelessWidget {
  static String route = "/favorites";

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meus Filmes Favoritos",
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
        child: BlocBuilder<FavoriteMovieListBloc, List<MovieModel>>(
          builder: (context, favoriteMovieList) {
            if (favoriteMovieList == null) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ),
              );
            } else {
              final FavoriteMovieListBloc favoriteMovieListBloc =
                  context.bloc<FavoriteMovieListBloc>();

              return ListView.builder(
                itemCount: favoriteMovieList.length,
                itemBuilder: (_, index) => FavoriteMovieCardWidget(
                  movieModel: favoriteMovieList[index],
                  screenSize: screenSize,
                  iconData: favoriteMovieListBloc
                          .isMovieFavorite(favoriteMovieList[index])
                      ? Icons.favorite
                      : Icons.favorite_border,
                  onPressed: () => favoriteMovieListBloc
                      .setFavoriteMovie(favoriteMovieList[index]),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

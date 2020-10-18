import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/models/movie_details_model.dart';
import '../../../shared/models/movie_model.dart';
import '../../favorites/views/favorites_screen.dart';
import '../../movie_details/views/movie_details_screen.dart';
import '../blocs/movies_list_bloc.dart';
import '../widgets/movie_tile.dart';

class HomeScreen extends StatefulWidget {
  static String route = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentCarouselPage = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildFavoritesButton(context),
              BlocBuilder<MoviesListBloc, List<MovieModel>>(
                builder: (_, movieList) {
                  final MoviesListBloc moviesListBloc =
                      context.bloc<MoviesListBloc>();

                  if (movieList == null) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).primaryColor),
                      ),
                    );
                  } else if (movieList.isEmpty) {
                    return _buildOnErrorContent(moviesListBloc);
                  } else {
                    return CarouselSlider.builder(
                      options: _buildCarouselOptions(screenSize),
                      itemCount: movieList?.length,
                      itemBuilder: (context, index) => MovieTitleWidget(
                        screenWidth: screenSize.width,
                        movieTitle: movieList[index].titulo,
                        imageUrl: movieList[index].poster,
                        sinopse: movieList[index].sinopse,
                        heroTag: "moviePoster$index",
                        onMovieSelected: index == this.currentCarouselPage
                            ? () => _onMovieSelectedCallback(
                                movieList[index], "moviePoster$index")
                            : null,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildOnErrorContent(MoviesListBloc moviesListBloc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            moviesListBloc.error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          FlatButton(
            onPressed: () {
              moviesListBloc.resetState();
              moviesListBloc.getAllMoviesFromApi();
            },
            child: const Text("Tentar novamente"),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamed(FavoritesScreen.route);
        },
        // textColor: Colors.white,
        child: const Text("Meus favoritos"),
      ),
    );
  }

  CarouselOptions _buildCarouselOptions(Size screenSize) {
    return CarouselOptions(
      height: screenSize.height * .6,
      enlargeCenterPage: true,
      viewportFraction: .65,
      onPageChanged: (carouselIndex, reason) {
        setState(() {
          this.currentCarouselPage = carouselIndex;
        });
      },
    );
  }

  Future<void> _onMovieSelectedCallback(MovieModel movie, String heroTag) {
    return Navigator.of(context).pushNamed(
      MovieDetailsScreen.route,
      arguments: MovieDetailsModel(movieModel: movie, heroTag: heroTag),
    );
  }
}

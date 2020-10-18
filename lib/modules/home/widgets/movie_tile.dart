import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieTitleWidget extends StatelessWidget {
  final String imageUrl;
  final String movieTitle;
  final String sinopse;
  final String heroTag;
  final double screenWidth;
  final Function() onMovieSelected;

  const MovieTitleWidget({
    Key key,
    this.imageUrl,
    this.movieTitle,
    this.screenWidth,
    this.onMovieSelected,
    this.sinopse,
    this.heroTag,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onMovieSelected,
      child: Column(
        children: [
          Expanded(
            child: Hero(
              tag: this.heroTag,
              child: CachedNetworkImage(
                imageUrl: this.imageUrl,
                fit: BoxFit.fitHeight,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            this.movieTitle,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          Text(
            this.sinopse,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/movie_model.dart';

class FavoriteMovieCardWidget extends StatelessWidget {
  final MovieModel movieModel;
  final Size screenSize;
  final IconData iconData;
  final Function onPressed;

  const FavoriteMovieCardWidget(
      {Key key,
      this.movieModel,
      this.screenSize,
      this.iconData,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30.0),
      child: Stack(
        alignment: Alignment.bottomLeft,
        overflow: Overflow.visible,
        children: [
          _buildBackgroundCard(),
          _buildPosterImage(),
        ],
      ),
    );
  }

  Positioned _buildPosterImage() {
    return Positioned(
      bottom: 15.0,
      left: 15.0,
      child: Container(
        width: 120.0,
        height: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: CachedNetworkImageProvider(
              this.movieModel.poster,
            ),
          ),
        ),
      ),
    );
  }

  Card _buildBackgroundCard() {
    return Card(
      child: Container(
        padding: const EdgeInsets.only(left: 145.0, right: 5.0),
        width: this.screenSize.width,
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    this.movieModel.titulo,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(this.movieModel.genero),
                  const SizedBox(height: 5.0),
                  Text(this.movieModel.data),
                ],
              ),
            ),
            const SizedBox(width: 5.0),
            IconButton(
              icon: Icon(this.iconData),
              onPressed: () => this.onPressed(),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}

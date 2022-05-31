import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homework_5/components/constants.dart';
import 'package:homework_5/domain/models/movie_card_model.dart';
import 'package:flutter_html/flutter_html.dart';

/// Элемент верстки нашей карточки с фильмом
class MovieCard extends StatelessWidget {
  final MovieCardModel? movieCardModel;

  const MovieCard({
    this.movieCardModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.tealAccent,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.teal.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: MovieColors.cardColor,
              ),
              child: CachedNetworkImage(
                imageUrl: '${movieCardModel?.picture}',
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Image.network(MovieQuery.pisecImageUrl),
                cacheManager: MoviePictures.pictureCache,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Text(
              '${movieCardModel?.title} (${movieCardModel?.releaseDate})',
              textAlign: TextAlign.justify,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Text(
            _rating(movieCardModel?.voteAverage ?? 0),
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            '${movieCardModel?.language}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Html(data: movieCardModel?.description ?? ''),
          )
        ],
      ),
    );
  }

  String _rating(double voteAverage) {
    const prefix = MovieLocal.ratingPrefix;
    const suffix = MovieLocal.ratingSuffix;
    final rating = (voteAverage * 10).toInt();
    return '$prefix $rating $suffix';
  }
}

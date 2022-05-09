import 'package:flutter/material.dart';
import 'package:homework_2/app/features/models/film_card_model.dart';

class FilmTile extends StatelessWidget {
  const FilmTile({
    required this.id,
    required this.title,
    required this.picture,
    required this.voteAverage,
    required this.releaseDate,
    required this.description,
    Key? key,
  }) : super(key: key);

  factory FilmTile.fromModel({
    required FilmCardModel model,
    Key? key,
  }) {
    return FilmTile(
      id: model.id,
      title: model.title,
      picture: model.picture,
      voteAverage: model.voteAverage,
      releaseDate: model.releaseDate,
      description: model.description,
      key: key,
    );
  }

  final int id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Image.network(
            picture,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ),
                      Expanded(
                        // оборачиваем наш текст в Expanded как указано в сообщении
                        child: Text(
                          voteAverage.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 16,
                            color: voteAverage < 4
                                ? Colors.red
                                : voteAverage >= 8
                                    ? Colors.green
                                    : Colors.black,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // и ограничиваем тремя точками в конце.
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Дата выхода: $releaseDate',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Text(description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

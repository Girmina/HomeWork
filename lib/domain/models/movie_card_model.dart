import 'package:homework_6/data/db/database.dart';

/// Чистая модель карточки с фильмом для отображения на UI
class MovieCardModel {
  final int id;
  final String title;
  final String? picture;
  final double? voteAverage;
  final String? releaseDate;
  final String? description;
  final String? language;

  const MovieCardModel({
    required this.id,
    required this.title,
    this.picture,
    this.releaseDate,
    this.voteAverage,
    this.description,
    this.language,
  });
}

/// Функция преобразования из [MovieCardModel] в [MovieTableData]
extension MovieCardModelToDatabase on MovieCardModel {
  MovieTableData toDatabase() {
    return MovieTableData(
      id: id,
      title: title,
      picture: picture,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      description: description,
      language: language,
    );
  }
}

/// Функция преобразования из [MovieTableData] в [MovieCardModel]
extension MovieTableDataToDomain on MovieTableData {
  MovieCardModel toDomain() {
    return MovieCardModel(
      id: id,
      title: title,
      picture: picture,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      description: description,
      language: language,
    );
  }
}

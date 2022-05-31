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

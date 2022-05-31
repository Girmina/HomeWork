import 'package:homework_4/data/dtos/show_card_dto.dart';
import 'package:homework_4/domain/models/movie_card_model.dart';

/// Функция преобразования из [ShowCardDTO] в [MovieCardModel]
extension ShowCardFromDTOToDomain on ShowCardDTO {
  MovieCardModel toDomain() {
    return MovieCardModel(
      id: show?.id ?? 0,
      title: show?.title ?? '',
      picture: show?.picture?.original ?? '',
      releaseDate: show?.releaseDate,
      voteAverage: score,
      description: show?.description,
      language: show?.language,
    );
  }
}

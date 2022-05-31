import 'package:dio/dio.dart';
import 'package:homework_5/components/constants.dart';
import 'package:homework_5/data/dtos/show_card_dto.dart';
import 'package:homework_5/data/mappers/show_mapper.dart';
import 'package:homework_5/data/repositories/intercaptors/error_interceptor.dart';
import 'package:homework_5/domain/models/home_model.dart';
import 'package:homework_5/domain/models/movie_card_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Репозиторий для получения данных о фильмах
class MoviesRepository {
  /// Метод обработчик наших ошибок
  final Function(String, String) onErrorHandler;

  /// Наш основной объект для выполнения запросов
  late final Dio _dio;

  MoviesRepository({required this.onErrorHandler}) {
    _dio = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
        ErrorInterceptor(onErrorHandler),
      ]);
  }

  /// Метод получения данных
  Future<HomeModel?> loadData({required String q}) async {
    // Выполняем запрос
    const String url = MovieQuery.baseUrl;
    final Response<dynamic> response = await _dio.get<List<dynamic>>(
      url,
      queryParameters: <String, dynamic>{'q': q},
    );

    // Парсим ДТО
    final dtos = <ShowCardDTO>[];
    final responseList = response.data as List<dynamic>;
    for (final data in responseList) {
      dtos.add(ShowCardDTO.fromJson(data as Map<String, dynamic>));
    }

    // Конвертируем ДТО в модели
    final movieModels = <MovieCardModel>[];
    for (final dto in dtos) {
      movieModels.add(dto.toDomain());
    }

    // Собираем модели карточек фильмов и возвращаем единую модель
    final HomeModel model = HomeModel(results: movieModels);
    return model;
  }
}

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:homework_6/components/constants.dart';
import 'package:homework_6/data/db/database.dart';
import 'package:homework_6/data/dtos/show_card_dto.dart';
import 'package:homework_6/data/mappers/show_mapper.dart';
import 'package:homework_6/data/repositories/intercaptors/error_interceptor.dart';
import 'package:homework_6/domain/models/home_model.dart';
import 'package:homework_6/domain/models/movie_card_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Репозиторий для получения данных о фильмах
class MoviesRepository {
  /// Метод обработчик наших ошибок
  final Function(String, String) onErrorHandler;

  /// Наш основной объект для выполнения запросов
  late final Dio _dio;

  /// Объект базы данных
  late final Database _db;

  MoviesRepository({required this.onErrorHandler}) {
    _dio = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
        ErrorInterceptor(onErrorHandler),
      ]);

    /// Инициализируем базу данных
    _db = Database();
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

  /// Получаем весь список фильмов из базы
  Future<List<MovieCardModel>> getAllMoviesDB() async {
    // Получаем список объектов из базы в моделях БД
    List<MovieTableData> moviesDB = await _db.select(_db.movieTable).get();
    // Преобразуем модели БД в понятные модели для наших виджетов
    return moviesDB
        .map((MovieTableData movieTableData) => movieTableData.toDomain())
        .toList();
  }

  /// Добавляем элемент из базы по ID
  Future<void> insertMovieDB(MovieCardModel movieCardModel) async {
    // Передаем нашу модель и преобразуем её в модель для БД с помощью .toDatabase()
    await _db.into(_db.movieTable).insert(
          movieCardModel.toDatabase(),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Удаляем элемент из базы по ID
  Future<void> deleteMovieDB(int id) async {
    await (_db.delete(_db.movieTable)
          ..where((movieTable) => movieTable.id.equals(id)))
        .go();
  }

  /// Подписка на изменения в БД
  Stream<List<MovieCardModel>> onChangedMoviesDB() {
    return (_db.select(_db.movieTable))
        .map((MovieTableData movieTableData) => movieTableData.toDomain())
        .watch();
  }
}

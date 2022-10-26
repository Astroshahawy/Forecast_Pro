import 'package:dio/dio.dart';
import 'package:forecast_pro/features/home_screen_weather/data/datasource/weather_remote_data_source.dart';
import 'package:forecast_pro/features/home_screen_weather/data/repository/home_weather_repository.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/repository/base_home_weather_repository.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/usecases/get_7_days_weather_usecase.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/usecases/get_weather_usecase.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/usecases/search_by_city_name_usecase.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initGetIt() {
  /// BLoC
  getIt.registerFactory(() => HomeWeatherBloc(getIt(), getIt(), getIt()));

  /// UseCases
  getIt.registerLazySingleton(() => GetWeatherUseCase(getIt()));
  getIt.registerLazySingleton(() => Get7DaysWeatherUseCase(getIt()));
  getIt.registerLazySingleton(() => SearchByCityNameUseCase(getIt()));

  /// Repository
  getIt.registerLazySingleton<BaseHomeWeatherRepository>(
      () => HomeWeatherRepository(getIt()));

  /// DataSource
  getIt.registerLazySingleton(() => WeatherRemoteDataSource(init()));
}

Dio init() {
  Dio dio = Dio();

  dio
    ..options.connectTimeout = 100 * 1000
    ..options.receiveTimeout = 100 * 1000;

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    error: true,
    requestHeader: false,
    responseHeader: false,
    request: true,
    responseBody: true,
  ));

  return dio;
}

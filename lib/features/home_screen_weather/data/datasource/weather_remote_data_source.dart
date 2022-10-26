import 'package:dio/dio.dart';
import 'package:forecast_pro/core/constants/constants.dart';
import 'package:forecast_pro/features/home_screen_weather/data/models/search_item_model.dart';
import 'package:forecast_pro/features/home_screen_weather/data/models/weather_model.dart';
import 'package:retrofit/retrofit.dart';

part 'weather_remote_data_source.g.dart';

@RestApi(baseUrl: AppApis.baseUrl)
abstract class WeatherRemoteDataSource {
  factory WeatherRemoteDataSource(Dio dio, {String baseUrl}) =
      _WeatherRemoteDataSource;

  @GET('${AppApis.forecastEndPoint}key=${AppApis.apiKey}')
  Future<WeatherModel> getWeather(@Query('q') String cityName);

  @GET('${AppApis.forecastEndPoint}key=${AppApis.apiKey}&days=7')
  Future<WeatherModel> get7DaysForecast(@Query('q') String cityName);

  @GET('${AppApis.searchEndPoint}key=${AppApis.apiKey}')
  Future<List<SearchItemModel>> searchByCityName(@Query('q') String cityName);
}

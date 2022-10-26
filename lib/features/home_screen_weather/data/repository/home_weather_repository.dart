import 'package:forecast_pro/features/home_screen_weather/data/datasource/weather_remote_data_source.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/search_item.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/weather.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/repository/base_home_weather_repository.dart';

class HomeWeatherRepository extends BaseHomeWeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  HomeWeatherRepository(this.weatherRemoteDataSource);

  @override
  Future<Weather> getWeather(String cityName) async {
    return await weatherRemoteDataSource.getWeather(cityName);
  }

  @override
  Future<Weather> get7DaysForecast(String cityName) async {
    return await weatherRemoteDataSource.get7DaysForecast(cityName);
  }

  @override
  Future<List<SearchItem>> searchByCityName(String cityName) async {
    return await weatherRemoteDataSource.searchByCityName(cityName);
  }
}

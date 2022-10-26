import 'package:forecast_pro/features/home_screen_weather/domain/entities/search_item.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/weather.dart';

abstract class BaseHomeWeatherRepository {
  Future<Weather> getWeather(String cityName);

  Future<Weather> get7DaysForecast(String cityName);

  Future<List<SearchItem>> searchByCityName(String cityName);
}

import 'package:forecast_pro/features/home_screen_weather/domain/entities/weather.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/repository/base_home_weather_repository.dart';

class Get7DaysWeatherUseCase {
  final BaseHomeWeatherRepository? baseHomeWeatherRepository;

  Get7DaysWeatherUseCase(this.baseHomeWeatherRepository);

  Future<Weather> call(String cityName) async {
    return await baseHomeWeatherRepository!.get7DaysForecast(cityName);
  }
}

import 'package:forecast_pro/features/home_screen_weather/domain/entities/weather.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/repository/base_home_weather_repository.dart';

class GetWeatherUseCase {
  final BaseHomeWeatherRepository? baseHomeWeatherRepository;

  GetWeatherUseCase(this.baseHomeWeatherRepository);

  Future<Weather> call(String cityName) async {
    return await baseHomeWeatherRepository!.getWeather(cityName);
  }
}

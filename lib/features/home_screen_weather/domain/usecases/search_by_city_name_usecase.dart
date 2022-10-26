import 'package:forecast_pro/features/home_screen_weather/domain/entities/search_item.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/repository/base_home_weather_repository.dart';

class SearchByCityNameUseCase {
  final BaseHomeWeatherRepository? baseHomeWeatherRepository;

  SearchByCityNameUseCase(this.baseHomeWeatherRepository);

  Future<List<SearchItem>> call(String cityName) async {
    return await baseHomeWeatherRepository!.searchByCityName(cityName);
  }
}

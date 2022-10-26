import 'package:forecast_pro/features/home_screen_weather/data/models/current_model.dart';
import 'package:forecast_pro/features/home_screen_weather/data/models/forecast_model.dart';
import 'package:forecast_pro/features/home_screen_weather/data/models/location_model.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.location,
    required super.current,
    required super.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        location: LocationModel.fromJson(json['location']),
        current: CurrentModel.fromJson(json['current']),
        forecast: ForecastModel.fromJson(json['forecast']),
      );
}

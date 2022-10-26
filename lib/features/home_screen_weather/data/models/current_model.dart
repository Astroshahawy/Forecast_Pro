import 'package:forecast_pro/features/home_screen_weather/data/models/condition_model.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/current.dart';

class CurrentModel extends Current {
  const CurrentModel({
    required super.lastUpdatedTime,
    required super.celsiusTemp,
    required super.condition,
    required super.windSpeed,
    required super.windDirection,
    required super.humidity,
    required super.celsiusFeelsLike,
    required super.uv,
    required super.isDay,
  });

  factory CurrentModel.fromJson(Map<String, dynamic> json) => CurrentModel(
        lastUpdatedTime: json['last_updated'],
        celsiusTemp: json['temp_c']?.toDouble(),
        condition: ConditionModel.fromJson(json['condition']),
        windSpeed: json['wind_kph']?.toDouble(),
        windDirection: json['wind_dir'],
        humidity: json['humidity']?.toInt(),
        celsiusFeelsLike: json['feelslike_c']?.toDouble(),
        uv: json['uv']?.toDouble(),
        isDay: json['is_day']?.toInt(),
      );
}

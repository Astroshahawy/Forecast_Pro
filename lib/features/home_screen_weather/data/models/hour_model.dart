import 'package:forecast_pro/features/home_screen_weather/data/models/condition_model.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/hour.dart';

class HourModel extends Hour {
  const HourModel({
    required super.time,
    required super.celsiusTemp,
    required super.condition,
    required super.windDirection,
    required super.chanceOfRain,
    required super.isDay,
  });

  factory HourModel.fromJson(Map<String, dynamic> json) => HourModel(
        time: json['time'],
        celsiusTemp: json['temp_c']?.toDouble(),
        condition: ConditionModel.fromJson(json['condition']),
        windDirection: json['wind_dir'],
        chanceOfRain: json['chance_of_rain']?.toInt(),
        isDay: json['is_day']?.toInt(),
      );
}

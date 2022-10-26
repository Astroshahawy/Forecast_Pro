import 'package:forecast_pro/features/home_screen_weather/data/models/condition_model.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/day.dart';

class DayModel extends Day {
  const DayModel({
    required super.celsiusMaxTemp,
    required super.celsiusMinTemp,
    required super.maxWindSpeed,
    required super.dailyChanceOfRain,
    required super.condition,
    required super.uv,
  });

  factory DayModel.fromJson(Map<String, dynamic> json) => DayModel(
        celsiusMaxTemp: json['maxtemp_c']?.toDouble(),
        celsiusMinTemp: json['mintemp_c']?.toDouble(),
        maxWindSpeed: json['maxwind_kph']?.toDouble(),
        dailyChanceOfRain: json['daily_chance_of_rain']?.toInt(),
        condition: ConditionModel.fromJson(json['condition']),
        uv: json['uv']?.toDouble(),
      );
}

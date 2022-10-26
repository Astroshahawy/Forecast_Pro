import 'package:equatable/equatable.dart';

import 'package:forecast_pro/features/home_screen_weather/domain/entities/condition.dart';

class Day extends Equatable {
  final double? celsiusMaxTemp;
  final double? celsiusMinTemp;
  final double? maxWindSpeed;
  final int? dailyChanceOfRain;
  final Condition? condition;
  final double? uv;

  const Day({
    required this.celsiusMaxTemp,
    required this.celsiusMinTemp,
    required this.maxWindSpeed,
    required this.dailyChanceOfRain,
    required this.condition,
    required this.uv,
  });

  @override
  List<Object?> get props {
    return [
      celsiusMaxTemp,
      celsiusMinTemp,
      maxWindSpeed,
      dailyChanceOfRain,
      condition,
      uv,
    ];
  }
}

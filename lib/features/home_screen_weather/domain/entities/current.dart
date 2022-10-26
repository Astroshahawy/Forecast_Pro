import 'package:equatable/equatable.dart';

import 'package:forecast_pro/features/home_screen_weather/domain/entities/condition.dart';

class Current extends Equatable {
  final String? lastUpdatedTime;
  final double? celsiusTemp;
  final Condition? condition;
  final double? windSpeed;
  final String? windDirection;
  final int? humidity;
  final double? celsiusFeelsLike;
  final double? uv;
  final int? isDay;

  const Current({
    required this.lastUpdatedTime,
    required this.celsiusTemp,
    required this.condition,
    required this.windSpeed,
    required this.windDirection,
    required this.humidity,
    required this.celsiusFeelsLike,
    required this.uv,
    required this.isDay,
  });

  @override
  List<Object?> get props {
    return [
      lastUpdatedTime,
      celsiusTemp,
      condition,
      windSpeed,
      windDirection,
      humidity,
      celsiusFeelsLike,
      uv,
      isDay,
    ];
  }
}

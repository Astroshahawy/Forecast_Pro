import 'package:equatable/equatable.dart';

import 'package:forecast_pro/features/home_screen_weather/domain/entities/condition.dart';

class Hour extends Equatable {
  final String? time;
  final double? celsiusTemp;
  final Condition? condition;
  final String? windDirection;
  final int? chanceOfRain;
  final int? isDay;

  const Hour({
    required this.time,
    required this.celsiusTemp,
    required this.condition,
    required this.windDirection,
    required this.chanceOfRain,
    required this.isDay,
  });

  @override
  List<Object?> get props =>
      [time, celsiusTemp, condition, windDirection, chanceOfRain, isDay];
}

import 'package:equatable/equatable.dart';

import 'package:forecast_pro/features/home_screen_weather/domain/entities/astro.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/day.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/hour.dart';

class Forecast extends Equatable {
  final List<ForecastDay>? forecastDay;

  const Forecast({
    required this.forecastDay,
  });

  @override
  List<Object?> get props => [forecastDay];
}

class ForecastDay extends Equatable {
  final String? date;
  final Day? day;
  final Astro? astro;
  final List<Hour>? hour;

  const ForecastDay({
    required this.date,
    required this.day,
    required this.astro,
    required this.hour,
  });

  @override
  List<Object?> get props {
    return [
      date,
      day,
      astro,
      hour,
    ];
  }
}

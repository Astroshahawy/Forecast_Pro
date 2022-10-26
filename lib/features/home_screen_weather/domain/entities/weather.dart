import 'package:equatable/equatable.dart';

import 'package:forecast_pro/features/home_screen_weather/domain/entities/current.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/forecast.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/location.dart';

class Weather extends Equatable {
  final Location? location;
  final Current? current;
  final Forecast? forecast;

  const Weather({
    required this.location,
    required this.current,
    required this.forecast,
  });

  @override
  List<Object?> get props => [location, current, forecast];
}

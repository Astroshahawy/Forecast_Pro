import 'package:forecast_pro/features/home_screen_weather/data/models/astro_model.dart';
import 'package:forecast_pro/features/home_screen_weather/data/models/day_model.dart';
import 'package:forecast_pro/features/home_screen_weather/data/models/hour_model.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/forecast.dart';

class ForecastModel extends Forecast {
  const ForecastModel({
    required super.forecastDay,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) => ForecastModel(
        forecastDay: List<ForecastDayModel>.from(
            json['forecastday']?.map((x) => ForecastDayModel.fromMap(x))),
      );
}

class ForecastDayModel extends ForecastDay {
  const ForecastDayModel({
    required super.date,
    required super.day,
    required super.astro,
    required super.hour,
  });

  factory ForecastDayModel.fromMap(Map<String, dynamic> json) =>
      ForecastDayModel(
        date: json['date'],
        day: DayModel.fromJson(json['day']),
        astro: AstroModel.fromJson(json['astro']),
        hour: List<HourModel>.from(
            json['hour']?.map((x) => HourModel.fromJson(x))),
      );
}

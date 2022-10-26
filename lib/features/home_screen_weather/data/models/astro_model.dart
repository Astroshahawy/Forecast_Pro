import 'package:forecast_pro/features/home_screen_weather/domain/entities/astro.dart';

class AstroModel extends Astro {
  const AstroModel({
    required super.sunriseTime,
    required super.sunsetTime,
  });

  factory AstroModel.fromJson(Map<String, dynamic> json) => AstroModel(
        sunriseTime: json['sunrise'],
        sunsetTime: json['sunset'],
      );
}

import 'package:flutter/material.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/home_body/hourly_weather.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/home_body/sun_condition.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/home_body/today_template.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/home_body/weather_condition.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/home_body/week_weather.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: const [
          HourlyWeather(),
          TodayTemplate(),
          WeekWeather(),
          SunCondition(),
          WeatherCondition(),
        ],
      ),
    );
  }
}

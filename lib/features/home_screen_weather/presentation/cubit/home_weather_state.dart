part of 'home_weather_cubit.dart';

abstract class HomeWeatherState {
  const HomeWeatherState();
}

class HomeWeatherInitial extends HomeWeatherState {}

class AppThemeChanged extends HomeWeatherState {}

class ScrollOffsetChanged extends HomeWeatherState {}

class ToggleDrawer extends HomeWeatherState {}

class CurrentWeatherDataLoaded extends HomeWeatherState {}

class WeatherDataLoaded extends HomeWeatherState {}

class OtherLocationsLoaded extends HomeWeatherState {}

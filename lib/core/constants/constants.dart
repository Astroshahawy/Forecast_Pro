import 'package:flutter/material.dart';

class AppRoutes {
  static const String initScreen = '/';
  static const String homeScreen = 'HOME_SCREEN';
  static const String manageLocationsScreen = 'MANAGE_LOCATIONS_SCREEN';
  static const String locationSearchScreen = 'LOCATION_SEARCH_SCREEN';
}

class AppColors {
  static const MaterialColor backgroundColor = Colors.indigo;
}

class AppApis {
  static const String apiKey = '173514b02f4144fa9e1200509220209';
  static const String baseUrl = 'http://api.weatherapi.com/v1/';
  static const String forecastEndPoint = 'forecast.json?';
  static const String searchEndPoint = 'search.json?';
}

class AppConstants {
  static const String appLogo = 'assets/forecast_pro.png';
  static const String branding = 'assets/branding.png';
  static const int appHeaderMaxExtent = 420;
  static const int appHeaderMinExtent = 210;
}

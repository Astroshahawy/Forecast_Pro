import 'package:flutter/material.dart';
import 'package:forecast_pro/core/constants/constants.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/screens/home_screen.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/screens/location_search/location_search_screen.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/screens/manage_locations/manage_locations_screen.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/screens/splash_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AppRouter {
  static Route? generateRoutes(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        switch (settings.name) {
          case AppRoutes.homeScreen:
            return const HomeScreen();
          case AppRoutes.manageLocationsScreen:
            return const LoaderOverlay(
              overlayColor: Colors.black87,
              child: ManageLocationsScreen(),
            );
          case AppRoutes.locationSearchScreen:
            return const LoaderOverlay(
              overlayColor: Colors.black87,
              child: LocationSearchScreen(),
            );
          case AppRoutes.initScreen:
          default:
            return const SplashScreen();
        }
      },
    );
  }
}

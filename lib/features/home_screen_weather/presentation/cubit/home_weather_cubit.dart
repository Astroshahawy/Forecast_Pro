import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:forecast_pro/features/home_screen_weather/domain/entities/hour.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/search_item.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/weather.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/usecases/get_7_days_weather_usecase.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/usecases/get_weather_usecase.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/usecases/search_by_city_name_usecase.dart';
import 'package:location/location.dart';

part 'home_weather_state.dart';

class HomeWeatherBloc extends Cubit<HomeWeatherState> {
  final GetWeatherUseCase getWeatherUseCase;
  final Get7DaysWeatherUseCase get7daysWeatherUseCase;
  final SearchByCityNameUseCase searchByCityNameUseCase;

  HomeWeatherBloc(
    this.getWeatherUseCase,
    this.get7daysWeatherUseCase,
    this.searchByCityNameUseCase,
  ) : super(HomeWeatherInitial());

  static HomeWeatherBloc get(context) =>
      BlocProvider.of<HomeWeatherBloc>(context);

  late Weather weather;
  late Weather favoriteLocation;

  Future<void> getWeather() async {
    await locationServices();
    weather = await get7daysWeatherUseCase(
        '${_locationData.latitude},${_locationData.longitude}'); //By Latitude and Longitude
    favoriteLocation = weather;

    addHourlyWeather();
  }

  List<Hour> hourlyWeather = <Hour>[];

  Future<void> addHourlyWeather() async {
    hourlyWeather = [];
    for (var hourWeather in weather.forecast!.forecastDay![0].hour!) {
      if (!DateTime.parse(hourWeather.time!).isBefore(DateTime.now())) {
        hourlyWeather.add(hourWeather);
      }
    }
    for (var hourWeather in weather.forecast!.forecastDay![1].hour!) {
      hourlyWeather.add(hourWeather);
    }
  }

  Future<List<SearchItem>> searchCity(String cityName) async {
    List<SearchItem> searchedCities = <SearchItem>[];
    if (cityName.trim().isEmpty) {
      return [];
    } else {
      searchedCities =
          await searchByCityNameUseCase(cityName); //By City name
      return searchedCities;
    }
  }

  List<Weather> otherLocations = <Weather>[];
  Future<void> addLocation(SearchItem city) async {
    List<SearchItem> locations = <SearchItem>[];
    locations.add(city);
    for (var city in locations) {
      final searchedWeather = await getWeatherUseCase(city.name!);
      otherLocations.add(searchedWeather);
    }
    emit(OtherLocationsLoaded());
  }

  Future<void> setNewWeather(String cityName) async {
    weather = await get7daysWeatherUseCase(cityName);
    await addHourlyWeather();
    emit(WeatherDataLoaded());
  }
// ===================================================================================
// ===================================================================================
// ===================================================================================
// ===================================================================================

  late ScrollController scrollController;
  bool darkTheme = false;
  DrawerState drawerState = DrawerState.closed;
  double scrollOffset = 0;
  ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  void setupScrollController(context) {
    scrollController = ScrollController()
      ..addListener(() {
        HomeWeatherBloc.get(context)
            .scrollOffsetChange(scrollController.offset);
      });
  }

  void changeAppTheme(bool switcher) {
    darkTheme = switcher;
    emit(AppThemeChanged());
  }

  void changeDrawerState() {
    drawerState = zoomDrawerController.stateNotifier!.value;
    drawerState == DrawerState.closed
        ? zoomDrawerController.stateNotifier!.removeListener(() {})
        : null;
  }

  void scrollOffsetChange(value) {
    scrollOffset = value;
    !((scrollOffset / 210) > 0.55) ? emit(ScrollOffsetChanged()) : null;
  }

  void toggleDrawer(context) {
    ZoomDrawer.of(context)!.toggle();
    drawerState = DrawerState.opening;
    emit(ToggleDrawer());
    ZoomDrawer.of(context)!.stateNotifier.addListener(
      () {
        changeDrawerState();
        emit(ToggleDrawer());
      },
    );
  }

  Color animateAppTextsColor() {
    return ((scrollOffset / 210) > 0)
        ? darkTheme
            ? Colors.white
            : Color.fromARGB(
                255,
                (255 - ((scrollOffset / 210) * 255)).clamp(0, 255).toInt(),
                (255 - ((scrollOffset / 210) * 255)).clamp(0, 255).toInt(),
                (255 - ((scrollOffset / 210) * 255)).clamp(0, 255).toInt(),
              )
        : Colors.white;
  }

  Color changeAppTextsTheme({double? whiteOpacity, double? blackOpacity}) {
    return ((scrollOffset / 210) > 0.3)
        ? darkTheme
            ? Colors.white.withOpacity(whiteOpacity ?? 1)
            : Colors.black.withOpacity(blackOpacity ?? 1)
        : Colors.white.withOpacity(whiteOpacity ?? 1);
  }

  Location location = Location();
  late LocationData _locationData;

  Future<void> locationServices() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:forecast_pro/core/constants/constants.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/home_main_screen.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/locations_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    HomeWeatherBloc.get(context).setupScrollController(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgroundColor.shade300,
            AppColors.backgroundColor.shade500,
            AppColors.backgroundColor.shade700,
          ],
        ),
      ),
      child: BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
        buildWhen: (previous, current) =>
            current is ScrollOffsetChanged ||
            current is ToggleDrawer ||
            current is AppThemeChanged,
        builder: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarIconBrightness:
                  ((HomeWeatherBloc.get(context).scrollOffset /
                                  AppConstants.appHeaderMinExtent)
                              .clamp(0, 1) >
                          0.3)
                      ? HomeWeatherBloc.get(context).darkTheme
                          ? Brightness.light
                          : Brightness.dark
                      : Brightness.light,
            ),
          );
          return ZoomDrawer(
            controller: HomeWeatherBloc.get(context).zoomDrawerController,
            slideWidth: MediaQuery.of(context).size.width * 0.8,
            menuScreenWidth: MediaQuery.of(context).size.width * 0.8,
            angle: 0.0,
            mainScreenScale: 0.0,
            borderRadius: 0,
            openCurve: const Interval(0.0, 0.0, curve: Curves.bounceInOut),
            closeCurve: const Interval(0.0, 0.0, curve: Curves.bounceInOut),
            mainScreenTapClose: true,
            androidCloseOnBackTap: true,
            menuScreen: const LocationDrawer(),
            mainScreen: const MainScreen(),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forecast_pro/core/constants/constants.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    HomeWeatherBloc.get(context).getWeather().then(
          (value) =>
              Navigator.pushReplacementNamed(context, AppRoutes.homeScreen),
        );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundColor.shade700,
              AppColors.backgroundColor.shade500,
              AppColors.backgroundColor.shade300,
              AppColors.backgroundColor.shade100,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    AppConstants.appLogo,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width * 0.4,
                    color: Colors.white,
                  ),
                  const SizedBox.square(
                    dimension: 200,
                  ),
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  const SizedBox.square(
                    dimension: 100,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Image.asset(
                  AppConstants.branding,
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
                const SizedBox.square(
                  dimension: 10,
                ),
                Text(
                  'Powered By WeatherAPI.com',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox.square(
                  dimension: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

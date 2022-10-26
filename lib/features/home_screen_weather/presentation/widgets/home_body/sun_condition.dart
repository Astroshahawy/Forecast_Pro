import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/home_body/semi_trans_container.dart';

class SunCondition extends StatelessWidget {
  const SunCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return SemiTransparentContainer(
      height: MediaQuery.of(context).size.height * 0.17,
      child: BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sunrise',
                    style: TextStyle(
                      fontSize: 20,
                      color: HomeWeatherBloc.get(context)
                          .changeAppTextsTheme(blackOpacity: 0.4),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    HomeWeatherBloc.get(context)
                        .weather
                        .forecast!
                        .forecastDay![0]
                        .astro!
                        .sunriseTime!
                        .toLowerCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: HomeWeatherBloc.get(context).changeAppTextsTheme(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Icon(
                    CupertinoIcons.sun_haze_fill,
                    size: 50,
                    color: Colors.amber,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sunset',
                    style: TextStyle(
                      fontSize: 20,
                      color: HomeWeatherBloc.get(context)
                          .changeAppTextsTheme(blackOpacity: 0.4),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    HomeWeatherBloc.get(context)
                        .weather
                        .forecast!
                        .forecastDay![0]
                        .astro!
                        .sunsetTime!
                        .toLowerCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: HomeWeatherBloc.get(context).changeAppTextsTheme(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Icon(
                    CupertinoIcons.sun_haze_fill,
                    size: 50,
                    color: Colors.deepOrange.shade300,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

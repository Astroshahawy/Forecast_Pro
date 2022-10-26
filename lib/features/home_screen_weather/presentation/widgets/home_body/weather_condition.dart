import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/home_body/semi_trans_container.dart';

class WeatherCondition extends StatelessWidget {
  const WeatherCondition({super.key});

  String uvIndex(context) {
    if (HomeWeatherBloc.get(context).weather.current!.uv! <= 2) {
      return 'Low';
    } else if (HomeWeatherBloc.get(context).weather.current!.uv! >= 3 &&
        HomeWeatherBloc.get(context).weather.current!.uv! <= 5) {
      return 'Moderate';
    } else if (HomeWeatherBloc.get(context).weather.current!.uv! >= 6 &&
        HomeWeatherBloc.get(context).weather.current!.uv! <= 7) {
      return 'High';
    } else if (HomeWeatherBloc.get(context).weather.current!.uv! >= 8 &&
        HomeWeatherBloc.get(context).weather.current!.uv! <= 10) {
      return 'Very High';
    } else if (HomeWeatherBloc.get(context).weather.current!.uv! >= 11) {
      return 'Extreme';
    } else {
      return 'No Data';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SemiTransparentContainer(
      height: MediaQuery.of(context).size.height * 0.17,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.circle_lefthalf_fill,
                      size: 40,
                      color: Colors.amber,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'UV index',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color:
                            HomeWeatherBloc.get(context).changeAppTextsTheme(),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      uvIndex(context),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: HomeWeatherBloc.get(context).changeAppTextsTheme(
                          whiteOpacity: 0.54,
                          blackOpacity: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
                VerticalDivider(
                  color: HomeWeatherBloc.get(context)
                      .changeAppTextsTheme(whiteOpacity: 0.24),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.wind,
                      size: 40,
                      color: HomeWeatherBloc.get(context).darkTheme
                          ? Colors.grey.shade300
                          : Colors.grey.shade600,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Wind',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color:
                            HomeWeatherBloc.get(context).changeAppTextsTheme(),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${HomeWeatherBloc.get(context).weather.current!.windSpeed!.toStringAsFixed(0)} Km/h',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: HomeWeatherBloc.get(context).changeAppTextsTheme(
                          whiteOpacity: 0.54,
                          blackOpacity: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
                VerticalDivider(
                  color: HomeWeatherBloc.get(context)
                      .changeAppTextsTheme(whiteOpacity: 0.24),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            CupertinoIcons.drop_fill,
                            size: 40,
                            color: HomeWeatherBloc.get(context).darkTheme
                                ? Colors.lightBlue.shade50
                                : Colors.lightBlue.shade100,
                          ),
                        ),
                        Icon(
                          CupertinoIcons.drop_fill,
                          size: 40,
                          color: Colors.lightBlue.shade200,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Humidity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color:
                            HomeWeatherBloc.get(context).changeAppTextsTheme(),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${HomeWeatherBloc.get(context).weather.current!.humidity!}%',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: HomeWeatherBloc.get(context).changeAppTextsTheme(
                          whiteOpacity: 0.54,
                          blackOpacity: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/home_body/semi_trans_container.dart';
import 'package:intl/intl.dart';

class HourlyWeather extends StatelessWidget {
  const HourlyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return SemiTransparentContainer(
      height: MediaQuery.of(context).size.height * 0.22,
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Colors.white,
              Colors.white,
              Colors.transparent,
              Colors.transparent,
              Colors.white,
              Colors.white,
            ],
            stops: [
              0.0,
              0.025,
              0.07,
              0.93,
              0.975,
              1.0,
            ],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
          builder: (context, state) {
            final hourlyWeather = HomeWeatherBloc.get(context).hourlyWeather;
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 24,
              itemBuilder: (BuildContext context, int index) {
                final hourWeather = hourlyWeather[index];
                return Container(
                  margin: EdgeInsets.only(
                    left: index == 0 ? 10.0 : 7.0,
                    right: index == 23 ? 10.0 : 7.0,
                  ),
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.j()
                            .format(DateTime.parse(hourWeather.time!)),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color:
                              HomeWeatherBloc.get(context).changeAppTextsTheme(
                            whiteOpacity: 0.7,
                            blackOpacity: 0.4,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Icon(
                        hourWeather.isDay == 1
                            ? hourWeather.condition!.text! == 'Sunny'
                                ? CupertinoIcons.sun_max_fill
                                : CupertinoIcons.cloud_sun_fill
                            : hourWeather.condition!.text! == 'Clear'
                                ? CupertinoIcons.moon_fill
                                : CupertinoIcons.cloud_moon_fill,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${hourWeather.celsiusTemp!.toStringAsFixed(0)}°',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: HomeWeatherBloc.get(context)
                              .changeAppTextsTheme(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.location_fill,
                              color: HomeWeatherBloc.get(context)
                                  .changeAppTextsTheme(
                                whiteOpacity: 0.24,
                                blackOpacity: 0.3,
                              ),
                              size: 14,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              hourWeather.windDirection!,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: HomeWeatherBloc.get(context)
                                    .changeAppTextsTheme(
                                  whiteOpacity: 0.54,
                                  blackOpacity: 0.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.drop_fill,
                              color:
                                  ((HomeWeatherBloc.get(context).scrollOffset /
                                              210) >
                                          0.3)
                                      ? Colors.lightBlue.shade200
                                      : Colors.white30,
                              size: 14,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              '${hourWeather.chanceOfRain}%',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: HomeWeatherBloc.get(context)
                                    .changeAppTextsTheme(
                                  whiteOpacity: 0.54,
                                  blackOpacity: 0.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/home_body/semi_trans_container.dart';
import 'package:intl/intl.dart';

class WeekWeather extends StatelessWidget {
  const WeekWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return SemiTransparentContainer(
      height: null,
      child: BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
        builder: (context, state) {
          final weekWeather =
              HomeWeatherBloc.get(context).weather.forecast!.forecastDay;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: weekWeather!.length,
            itemBuilder: (BuildContext context, int index) {
              final dayWeather = weekWeather[index];
              return Container(
                margin: EdgeInsets.fromLTRB(
                  0,
                  index == weekWeather.indexOf(weekWeather.first) ? 20 : 10,
                  0,
                  index == weekWeather.indexOf(weekWeather.last) ? 20 : 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        !DateTime.parse(dayWeather.date!)
                                .isAfter(DateTime.now())
                            ? 'Today'
                            : DateFormat('EEEE')
                                .format(DateTime.parse(dayWeather.date!)),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: HomeWeatherBloc.get(context)
                              .changeAppTextsTheme(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.drop_fill,
                          color: ((HomeWeatherBloc.get(context).scrollOffset /
                                      210) >
                                  0.3)
                              ? Colors.lightBlue.shade200
                              : Colors.white30,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          '${dayWeather.day!.dailyChanceOfRain}%',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: HomeWeatherBloc.get(context)
                                .changeAppTextsTheme(
                              whiteOpacity: 0.54,
                              blackOpacity: 0.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Icon(
                      dayWeather.day!.condition!.text! == 'Sunny'
                          ? CupertinoIcons.sun_max_fill
                          : CupertinoIcons.cloud_sun_fill,
                      color: Colors.amber,
                      size: 26,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Icon(
                      dayWeather.day!.condition!.text! == 'Sunny'
                          ? CupertinoIcons.moon_fill
                          : CupertinoIcons.cloud_moon_fill,
                      color: Colors.amber,
                      size: 26,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${dayWeather.day!.celsiusMaxTemp!.toStringAsFixed(0)}° ${dayWeather.day!.celsiusMinTemp!.toStringAsFixed(0)}°',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color:
                            HomeWeatherBloc.get(context).changeAppTextsTheme(),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

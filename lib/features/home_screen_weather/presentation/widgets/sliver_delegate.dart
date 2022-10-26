import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_pro/core/constants/constants.dart';

import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';
import 'package:intl/intl.dart';

class CustomAppBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / 300;
    return BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
      buildWhen: (previous, current) => current is AppThemeChanged,
      builder: (context, state) {
        return Container(
          color: ((HomeWeatherBloc.get(context).scrollOffset /
                          AppConstants.appHeaderMinExtent)
                      .clamp(0, 1) ==
                  1)
              ? HomeWeatherBloc.get(context).darkTheme
                  ? Colors.black
                  : Colors.grey[200]!
              : Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                left: 25,
                top: 30,
                child: GestureDetector(
                  onTap: () {
                    HomeWeatherBloc.get(context).toggleDrawer(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Icon(
                      Icons.menu_rounded,
                      size: 36,
                      color: HomeWeatherBloc.get(context).changeAppTextsTheme(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 33,
                left: 90,
                child: BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
                  buildWhen: (previous, current) =>
                      current is WeatherDataLoaded,
                  builder: (context, state) {
                    return shrinkOffset > 0
                        ? AnimatedOpacity(
                            duration: const Duration(milliseconds: 0),
                            curve:
                                const Interval(0.0, 1.0, curve: Curves.linear),
                            opacity: (HomeWeatherBloc.get(context)
                                        .scrollOffset /
                                    (MediaQuery.of(context).size.height * 0.15))
                                .clamp(0, 1),
                            child: Row(
                              children: [
                                Text(
                                  '${HomeWeatherBloc.get(context).weather.location!.name!}, ${HomeWeatherBloc.get(context).weather.location!.region!}',
                                  style: TextStyle(
                                    fontSize: 26,
                                    color:
                                        HomeWeatherBloc.get(context).darkTheme
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                                const SizedBox.square(
                                  dimension: 5,
                                ),
                                Icon(
                                  Icons.location_on_rounded,
                                  color: HomeWeatherBloc.get(context).darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                  size: 20,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox();
                  },
                ),
              ),
              Positioned(
                top: (110 - (10 * percent)).clamp(105, 110),
                left: (40 - (10 * percent)).clamp(35, 40),
                child: BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
                  buildWhen: (previous, current) =>
                      current is WeatherDataLoaded,
                  builder: (context, state) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          HomeWeatherBloc.get(context)
                              .weather
                              .current!
                              .celsiusTemp!
                              .toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 85,
                            fontWeight: FontWeight.w200,
                            color: HomeWeatherBloc.get(context)
                                .animateAppTextsColor(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            '°',
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w200,
                              color: HomeWeatherBloc.get(context)
                                  .animateAppTextsColor(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                top: (110 - (10 * percent)).clamp(105, 110),
                right: (40 - (10 * percent)).clamp(35, 40),
                child: BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
                  buildWhen: (previous, current) =>
                      current is WeatherDataLoaded,
                  builder: (context, state) {
                    return Icon(
                      HomeWeatherBloc.get(context).weather.current!.isDay == 1
                          ? HomeWeatherBloc.get(context)
                                      .weather
                                      .current!
                                      .condition!
                                      .text! ==
                                  'Sunny'
                              ? CupertinoIcons.sun_max_fill
                              : CupertinoIcons.cloud_sun_fill
                          : HomeWeatherBloc.get(context)
                                      .weather
                                      .current!
                                      .condition!
                                      .text! ==
                                  'Clear'
                              ? CupertinoIcons.moon_fill
                              : CupertinoIcons.cloud_moon_fill,
                      size: 90,
                      color: Colors.amber,
                    );
                  },
                ),
              ),
              Positioned(
                left: 40,
                top: (220 - (100 * percent)),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 0),
                  curve: const Interval(0.0, 1.0, curve: Curves.linear),
                  opacity: (1 -
                          (HomeWeatherBloc.get(context).scrollOffset /
                              (MediaQuery.of(context).size.height * 0.1)))
                      .clamp(0, 1),
                  child: BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
                    buildWhen: (previous, current) =>
                        current is WeatherDataLoaded,
                    builder: (context, state) {
                      return Row(
                        children: [
                          Text(
                            HomeWeatherBloc.get(context)
                                .weather
                                .location!
                                .name!,
                            style: TextStyle(
                              fontSize: 30,
                              color: HomeWeatherBloc.get(context)
                                  .animateAppTextsColor(),
                            ),
                          ),
                          const SizedBox.square(
                            dimension: 5,
                          ),
                          Icon(
                            Icons.location_on_rounded,
                            color: HomeWeatherBloc.get(context)
                                .animateAppTextsColor(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                left: (40 + (177 * percent)).clamp(40, 170),
                top: (300 - (225 * percent)).clamp(135, 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${HomeWeatherBloc.get(context).weather.forecast!.forecastDay![0].day!.celsiusMaxTemp!.toStringAsFixed(0)}° / ${HomeWeatherBloc.get(context).weather.forecast!.forecastDay![0].day!.celsiusMinTemp!.toStringAsFixed(0)}°',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: HomeWeatherBloc.get(context)
                                .animateAppTextsColor(),
                          ),
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 0),
                          curve: const Interval(0.0, 1.0, curve: Curves.linear),
                          opacity: (1 -
                                  (HomeWeatherBloc.get(context).scrollOffset /
                                      (MediaQuery.of(context).size.height *
                                          0.1)))
                              .clamp(0, 1),
                          child: BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
                            buildWhen: (previous, current) =>
                                current is WeatherDataLoaded,
                            builder: (context, state) {
                              return Text(
                                ' Feels like ${HomeWeatherBloc.get(context).weather.current!.celsiusFeelsLike!.toStringAsFixed(0)}°',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: HomeWeatherBloc.get(context)
                                      .animateAppTextsColor(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox.square(
                      dimension: 5,
                    ),
                    BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
                      buildWhen: (previous, current) =>
                          current is WeatherDataLoaded,
                      builder: (context, state) {
                        return Text(
                          DateFormat('EEE, ').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    HomeWeatherBloc.get(context)
                                            .weather
                                            .location!
                                            .localTimeEpoch! *
                                        1000),
                              ) +
                              DateFormat.jm()
                                  .format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      HomeWeatherBloc.get(context)
                                              .weather
                                              .location!
                                              .localTimeEpoch! *
                                          1000,
                                    ),
                                  )
                                  .toLowerCase(),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: HomeWeatherBloc.get(context)
                                .animateAppTextsColor(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => AppConstants.appHeaderMaxExtent.toDouble();

  @override
  double get minExtent => AppConstants.appHeaderMinExtent.toDouble();

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

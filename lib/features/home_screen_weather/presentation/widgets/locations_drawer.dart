import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:forecast_pro/core/constants/constants.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/scrim.dart';

class LocationDrawer extends StatelessWidget {
  const LocationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
      buildWhen: (previous, current) =>
          current is AppThemeChanged || current is ToggleDrawer,
      builder: (context, state) {
        return Stack(
          children: [
            Scrim(
              applied: HomeWeatherBloc.get(context).drawerState ==
                      DrawerState.open ||
                  HomeWeatherBloc.get(context).drawerState ==
                      DrawerState.opening,
              color: Colors.black,
              opacity: 0.7,
              child: Scaffold(
                backgroundColor: HomeWeatherBloc.get(context).darkTheme
                    ? Colors.black.withOpacity(
                        (HomeWeatherBloc.get(context).scrollOffset /
                                (AppConstants.appHeaderMinExtent * 0.55))
                            .clamp(0, 1),
                      )
                    : Colors.grey[200]!.withOpacity(
                        (HomeWeatherBloc.get(context).scrollOffset /
                                (AppConstants.appHeaderMinExtent * 0.55))
                            .clamp(0, 1),
                      ),
              ),
            ),
            SafeArea(
              minimum: const EdgeInsets.only(top: 60),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: ((HomeWeatherBloc.get(context).scrollOffset /
                                  AppConstants.appHeaderMinExtent)
                              .clamp(0, 1) >
                          0.55)
                      ? HomeWeatherBloc.get(context).darkTheme
                          ? LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.grey.shade900,
                                Colors.grey.shade900,
                                Colors.grey.shade900,
                              ],
                            )
                          : LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.grey.shade900.withOpacity(0.4),
                                Colors.grey.shade900.withOpacity(0.4),
                                Colors.grey.shade900.withOpacity(0.35),
                              ],
                            )
                      : LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey.withOpacity(0.210),
                            Colors.grey.withOpacity(0.205),
                            Colors.grey.withOpacity(0.2),
                          ],
                        ),
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.settings_outlined,
                        size: 32,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox.square(
                      dimension: 50,
                    ),
                    const FavoriteLocationSection(),
                    const SizedBox.square(
                      dimension: 20,
                    ),
                    const OtherLocationsSection(),
                    const SizedBox.square(
                      dimension: 20,
                    ),
                    const BottomSection(),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          'Dark mode',
                          style: TextStyle(
                            fontSize: 22,
                            letterSpacing: 0.5,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        const Spacer(),
                        CupertinoSwitch(
                          value: HomeWeatherBloc.get(context).darkTheme,
                          onChanged: (switcher) {
                            HomeWeatherBloc.get(context)
                                .changeAppTheme(switcher);
                          },
                          activeColor: AppColors.backgroundColor.shade500,
                          trackColor: Colors.black54,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class FavoriteLocationSection extends StatelessWidget {
  const FavoriteLocationSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.star_rounded,
              size: 38,
              color: Colors.white.withOpacity(0.9),
            ),
            const SizedBox.square(
              dimension: 20,
            ),
            Text(
              'Favorite location',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.info_outline_rounded,
              size: 26,
              color: Colors.white,
            ),
          ],
        ),
        const SizedBox.square(
          dimension: 30,
        ),
        Row(
          children: [
            const SizedBox(
              width: 40,
            ),
            const Icon(
              Icons.location_on,
              size: 14,
              color: Colors.white,
            ),
            const SizedBox.square(
              dimension: 5,
            ),
            Text(
              HomeWeatherBloc.get(context).favoriteLocation.location!.name!,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Icon(
              HomeWeatherBloc.get(context).favoriteLocation.current!.isDay == 1
                  ? HomeWeatherBloc.get(context)
                              .favoriteLocation
                              .current!
                              .condition!
                              .text! ==
                          'Sunny'
                      ? CupertinoIcons.sun_max_fill
                      : CupertinoIcons.cloud_sun_fill
                  : HomeWeatherBloc.get(context)
                              .favoriteLocation
                              .current!
                              .condition!
                              .text! ==
                          'Clear'
                      ? CupertinoIcons.moon_fill
                      : CupertinoIcons.cloud_moon_fill,
              color: Colors.amber,
              size: 26,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${HomeWeatherBloc.get(context).favoriteLocation.current!.celsiusTemp!.toStringAsFixed(0)}°',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
        const SizedBox.square(
          dimension: 20,
        ),
        Divider(
          color: Colors.white.withOpacity(0.7),
          thickness: 1,
        ),
      ],
    );
  }
}

class OtherLocationsSection extends StatelessWidget {
  const OtherLocationsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
      buildWhen: (previous, current) => current is OtherLocationsLoaded,
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.add_location_outlined,
                  size: 30,
                  color: Colors.white.withOpacity(0.9),
                ),
                const SizedBox.square(
                  dimension: 20,
                ),
                Text(
                  'Other locations',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            const SizedBox.square(
              dimension: 30,
            ),
            if (HomeWeatherBloc.get(context).otherLocations.isNotEmpty)
              Row(
                children: [
                  const SizedBox(
                    width: 52,
                  ),
                  Text(
                    HomeWeatherBloc.get(context)
                        .otherLocations[0]
                        .location!
                        .name!,
                    style: TextStyle(
                      fontSize: 22,
                      letterSpacing: 0.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    HomeWeatherBloc.get(context)
                                .otherLocations[0]
                                .current!
                                .isDay ==
                            1
                        ? HomeWeatherBloc.get(context)
                                    .otherLocations[0]
                                    .current!
                                    .condition!
                                    .text! ==
                                'Sunny'
                            ? CupertinoIcons.sun_max_fill
                            : CupertinoIcons.cloud_sun_fill
                        : HomeWeatherBloc.get(context)
                                    .otherLocations[0]
                                    .current!
                                    .condition!
                                    .text! ==
                                'Clear'
                            ? CupertinoIcons.moon_fill
                            : CupertinoIcons.cloud_moon_fill,
                    color: Colors.amber,
                    size: 26,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${HomeWeatherBloc.get(context).otherLocations[0].current!.celsiusTemp!.toStringAsFixed(0)}°',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            if (HomeWeatherBloc.get(context).otherLocations.isNotEmpty)
              const SizedBox.square(
                dimension: 30,
              ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.manageLocationsScreen);
                ZoomDrawer.of(context)!.toggle();
              },
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 5),
                decoration: const BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(23),
                  ),
                ),
                child: Text(
                  'Manage locations',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ),
            const SizedBox.square(
              dimension: 10,
            ),
            Divider(
              color: Colors.white.withOpacity(0.7),
              thickness: 1,
            ),
          ],
        );
      },
    );
  }
}

class BottomSection extends StatelessWidget {
  const BottomSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              size: 26,
              color: Colors.white.withOpacity(0.9),
            ),
            const SizedBox.square(
              dimension: 20,
            ),
            Text(
              'Report wrong location',
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 0.5,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
        const SizedBox.square(
          dimension: 40,
        ),
        Row(
          children: [
            Icon(
              Icons.headset_mic_outlined,
              size: 26,
              color: Colors.white.withOpacity(0.9),
            ),
            const SizedBox.square(
              dimension: 20,
            ),
            Text(
              'Contact us',
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 0.5,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
        const SizedBox.square(
          dimension: 30,
        ),
      ],
    );
  }
}

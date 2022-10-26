import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/screens/manage_locations/widgets/location_item.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:macos_ui/macos_ui.dart';

class FavoriteSection extends StatelessWidget {
  const FavoriteSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Favorite location',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox.square(
            dimension: 20,
          ),
          GestureDetector(
            onLongPress: () {
              showMacosAlertDialog(
                context: context,
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.65),
                builder: (_) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text(
                      'Choose location',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        letterSpacing: 0.5,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: Text(
                      'Are you sure you want to load data from this location?',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('NO'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: const Text('YES'),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          context.loaderOverlay.show(
                            widget: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                          await HomeWeatherBloc.get(context).setNewWeather(
                            HomeWeatherBloc.get(context)
                                .favoriteLocation
                                .location!
                                .name!,
                          );
                          context.loaderOverlay.hide();
                        },
                      ),
                    ],
                    insetPadding: const EdgeInsets.symmetric(
                      horizontal: 80,
                    ),
                  );
                },
              );
            },
            child: LocationItem(
              isFavorite: true,
              locationName:
                  HomeWeatherBloc.get(context).favoriteLocation.location!.name!,
              regionName:
                  '${HomeWeatherBloc.get(context).favoriteLocation.location!.region!}, ${HomeWeatherBloc.get(context).favoriteLocation.location!.country!}',
              date: '${DateFormat('EEE, MMMM dd').format(
                DateTime.fromMillisecondsSinceEpoch(HomeWeatherBloc.get(context)
                        .weather
                        .location!
                        .localTimeEpoch! *
                    1000),
              )} - ${DateFormat.jm().format(
                DateTime.fromMillisecondsSinceEpoch(
                  HomeWeatherBloc.get(context)
                          .favoriteLocation
                          .location!
                          .localTimeEpoch! *
                      1000,
                ),
              )}',
              icon: HomeWeatherBloc.get(context)
                          .favoriteLocation
                          .current!
                          .isDay ==
                      1
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
              temp:
                  '${HomeWeatherBloc.get(context).favoriteLocation.current!.celsiusTemp!.toStringAsFixed(0)}°',
              dayTemp:
                  '${HomeWeatherBloc.get(context).favoriteLocation.forecast!.forecastDay![0].day!.celsiusMaxTemp!.toStringAsFixed(0)}°/${HomeWeatherBloc.get(context).favoriteLocation.forecast!.forecastDay![0].day!.celsiusMinTemp!.toStringAsFixed(0)}°',
            ),
          ),
        ],
      ),
    );
  }
}

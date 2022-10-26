import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_pro/core/constants/constants.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/screens/manage_locations/widgets/fav_section.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/screens/manage_locations/widgets/location_item.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/screens/manage_locations/widgets/top_bar.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:macos_ui/macos_ui.dart';

class ManageLocationsScreen extends StatelessWidget {
  const ManageLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgroundColor.shade700,
            AppColors.backgroundColor.shade500,
            AppColors.backgroundColor.shade300,
          ],
        ),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.only(top: 70),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ManageLocationsTopBar(),
              const SizedBox.square(
                dimension: 20,
              ),
              const FavoriteSection(),
              const SizedBox.square(
                dimension: 15,
              ),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (Rect rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
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
                        0.01,
                        0.03,
                        0.97,
                        0.99,
                        1.0,
                      ],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox.square(
                          dimension: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'Other locations',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ),
                        const SizedBox.square(
                          dimension: 20,
                        ),
                        BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
                          buildWhen: (previous, current) =>
                              current is OtherLocationsLoaded,
                          builder: (context, state) {
                            final otherLocations =
                                HomeWeatherBloc.get(context).otherLocations;
                            return ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              itemCount: otherLocations.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final city = otherLocations[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onLongPress: () async {
                                      showMacosAlertDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierColor:
                                            Colors.black.withOpacity(0.65),
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                              ),
                                              TextButton(
                                                child: const Text('YES'),
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                  context.loaderOverlay.show(
                                                    widget: const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  );
                                                  await HomeWeatherBloc.get(
                                                          context)
                                                      .setNewWeather(
                                                    city.location!.name!,
                                                  );
                                                  context.loaderOverlay.hide();
                                                },
                                              ),
                                            ],
                                            insetPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 80,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: LocationItem(
                                      isFavorite: true,
                                      locationName: city.location!.name!,
                                      regionName:
                                          '${(city.location!.region! == '' ? '' : '${city.location!.region!}, ')}${city.location!.country!}',
                                      date:
                                          '${DateFormat('EEE, MMMM dd').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            city.location!.localTimeEpoch! *
                                                1000),
                                      )} - ${DateFormat.jm().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                          city.location!.localTimeEpoch! * 1000,
                                        ),
                                      )}',
                                      icon: city.current!.isDay == 1
                                          ? city.current!.condition!.text! ==
                                                  'Sunny'
                                              ? CupertinoIcons.sun_max_fill
                                              : CupertinoIcons.cloud_sun_fill
                                          : city.current!.condition!.text! ==
                                                  'Clear'
                                              ? CupertinoIcons.moon_fill
                                              : CupertinoIcons.cloud_moon_fill,
                                      temp:
                                          '${city.current!.celsiusTemp!.toStringAsFixed(0)}°',
                                      dayTemp:
                                          '${city.forecast!.forecastDay![0].day!.celsiusMaxTemp!.toStringAsFixed(0)}°/${city.forecast!.forecastDay![0].day!.celsiusMinTemp!.toStringAsFixed(0)}°',
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

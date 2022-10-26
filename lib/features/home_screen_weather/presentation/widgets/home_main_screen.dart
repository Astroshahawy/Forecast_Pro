import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:forecast_pro/core/constants/constants.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/home_body/home_body.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/scrim.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/sliver_delegate.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
      builder: (context, state) {
        return Scrim(
          applied: HomeWeatherBloc.get(context).drawerState ==
                  DrawerState.open ||
              HomeWeatherBloc.get(context).drawerState == DrawerState.opening,
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
            body: SafeArea(
              minimum: const EdgeInsets.only(top: 60),
              child: CustomScrollView(
                controller: HomeWeatherBloc.get(context).scrollController,
                scrollBehavior: const MaterialScrollBehavior(
                    androidOverscrollIndicator:
                        AndroidOverscrollIndicator.stretch),
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: CustomAppBarHeaderDelegate(),
                  ),
                  const HomeBody(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

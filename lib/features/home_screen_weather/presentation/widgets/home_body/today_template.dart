import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/widgets/home_body/semi_trans_container.dart';

class TodayTemplate extends StatelessWidget {
  const TodayTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return SemiTransparentContainer(
      height: MediaQuery.of(context).size.height * 0.11,
      child: Center(
        child: BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Today\'s Temperature',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: HomeWeatherBloc.get(context).changeAppTextsTheme(),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  'Expect the same as yesterday',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: HomeWeatherBloc.get(context).changeAppTextsTheme(
                      whiteOpacity: 0.38,
                      blackOpacity: 0.4,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

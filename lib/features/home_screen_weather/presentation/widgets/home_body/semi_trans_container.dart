import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';

class SemiTransparentContainer extends StatelessWidget {
  final double? height;
  final Widget child;
  const SemiTransparentContainer({
    Key? key,
    required this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeWeatherBloc, HomeWeatherState>(
      builder: (context, state) {
        return Container(
          height: height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
            border: Border.all(
              color: ((HomeWeatherBloc.get(context).scrollOffset / 210) > 0.3)
                  ? HomeWeatherBloc.get(context).darkTheme
                      ? Colors.grey.shade900
                      : Colors.white38
                  : Colors.white12,
              width: 2,
            ),
            color: ((HomeWeatherBloc.get(context).scrollOffset / 210) > 0.3)
                ? HomeWeatherBloc.get(context).darkTheme
                    ? Colors.grey.shade900
                    : Colors.white38
                : Colors.white24,
          ),
          child: child,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_pro/core/routes/app_router.dart';

import '../core/injection/injector.dart';
import '../features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return BlocProvider(
      create: (context) => getIt<HomeWeatherBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        restorationScopeId: 'app',
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        darkTheme: ThemeData.dark(),
        onGenerateRoute: AppRouter.generateRoutes,
      ),
    );
  }
}

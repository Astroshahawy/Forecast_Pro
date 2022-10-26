import 'package:equatable/equatable.dart';

class Astro extends Equatable {
  final String? sunriseTime;
  final String? sunsetTime;

  const Astro({
    required this.sunriseTime,
    required this.sunsetTime,
  });

  @override
  List<Object?> get props => [sunriseTime, sunsetTime];
}

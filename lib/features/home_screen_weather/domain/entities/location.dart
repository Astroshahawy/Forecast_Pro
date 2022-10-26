import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String? name;
  final String? region;
  final String? country;
  final String? timezone;
  final int? localTimeEpoch;

  const Location({
    required this.name,
    required this.region,
    required this.country,
    required this.timezone,
   required this.localTimeEpoch,
  });

  @override
  List<Object?> get props => [name, region, country, timezone, localTimeEpoch];
}

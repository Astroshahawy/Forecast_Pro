import 'dart:convert';

import 'package:equatable/equatable.dart';

class SearchItem extends Equatable {
  final int? id;
  final String? name;
  final String? region;
  final String? country;
  final double? latitude;
  final double? longitude;

  const SearchItem({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      region,
      country,
      latitude,
      longitude,
    ];
  }
}

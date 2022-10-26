import 'package:forecast_pro/features/home_screen_weather/domain/entities/search_item.dart';

class SearchItemModel extends SearchItem {
  const SearchItemModel({
    required super.id,
    required super.name,
    required super.region,
    required super.country,
    required super.latitude,
    required super.longitude,
  });

  factory SearchItemModel.fromJson(Map<String, dynamic> json) {
    return SearchItemModel(
      id: json['id']?.toInt(),
      name: json['name'],
      region: json['region'],
      country: json['country'],
      latitude: json['lat']?.toDouble(),
      longitude: json['lon']?.toDouble(),
    );
  }
}

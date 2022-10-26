import 'package:forecast_pro/features/home_screen_weather/domain/entities/condition.dart';

class ConditionModel extends Condition {
  const ConditionModel({
    required super.text,
    required super.icon,
  });

  factory ConditionModel.fromJson(Map<String, dynamic> json) => ConditionModel(
        text: json['text'],
        icon: json['icon'],
      );
}

import 'package:flutter/material.dart';

import 'package:forecast_pro/core/constants/constants.dart';

class LocationItem extends StatelessWidget {
  final bool isFavorite;
  final String locationName;
  final String regionName;
  final String date;
  final IconData icon;
  final String temp;
  final String dayTemp;

  const LocationItem({
    Key? key,
    this.isFavorite = false,
    required this.locationName,
    required this.regionName,
    required this.date,
    required this.icon,
    required this.temp,
    required this.dayTemp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white38,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (isFavorite)
                    Icon(
                      Icons.location_on,
                      size: 22,
                      color: AppColors.backgroundColor.shade500,
                    ),
                  if (isFavorite)
                    const SizedBox.square(
                      dimension: 5,
                    ),
                  Text(
                    locationName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: AppColors.backgroundColor.shade500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  regionName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: Colors.white.withOpacity(0.9),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.amber,
                    size: 38,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    temp,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 32,
                      color: AppColors.backgroundColor.shade500,
                    ),
                  ),
                ],
              ),
              const SizedBox.square(
                dimension: 10,
              ),
              Text(
                dayTemp,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

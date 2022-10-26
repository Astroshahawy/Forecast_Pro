import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast_pro/core/constants/constants.dart';

class ManageLocationsTopBar extends StatelessWidget {
  const ManageLocationsTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.transparent,
            child: const Icon(
              CupertinoIcons.back,
              size: 36,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        const Text(
          'Manage locations',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.locationSearchScreen);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.transparent,
            child: const Icon(
              CupertinoIcons.add,
              size: 36,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

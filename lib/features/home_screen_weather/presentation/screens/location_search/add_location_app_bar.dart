import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddLocationTopBar extends StatelessWidget {
  const AddLocationTopBar({super.key});

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
          'Add location',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

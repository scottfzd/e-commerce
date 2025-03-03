import 'package:flutter/material.dart';

class NoImageWidget extends StatelessWidget {
  const NoImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.image_not_supported,
        size: 50,
        color: Colors.grey,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NoImageWidget extends StatelessWidget {
  final double size;

  const NoImageWidget({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.image_not_supported,
      size: size,
      color: Colors.grey,
    );
  }
}

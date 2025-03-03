import 'package:flutter/material.dart';

class NoContentWidget extends StatelessWidget {
  final String message;
  const NoContentWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}

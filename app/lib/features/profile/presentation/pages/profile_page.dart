import 'package:app/features/profile/presentation/widgets/dark_mode.dart';
import 'package:app/features/profile/presentation/widgets/language_mode.dart';
import 'package:app/features/profile/presentation/widgets/logout.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            darkMode(context),
            const SizedBox(height: 20),
            languageMode(context),
            const SizedBox(height: 20),
            logout(context),
          ],
        ),
      ),
    );
  }
}

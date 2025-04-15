import 'package:flutter/material.dart';

import '../../core/core.dart';
import 'login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => context.pushReplacement(const LoginPage()),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(96.0),
        child: Center(
          child: Assets.images.logoAppBlue.image(),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100.0,
        child: Align(
          alignment: Alignment.center,
          child: Assets.images.logoIdn.image(width: 96.0),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/data/datasources/auth_local_datasource.dart';
import 'package:frontend/presentation/ui/home/pages/main_page.dart';

import '../../../core/core.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _local = AuthLocalDatasource();

  String? _token;

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    final token = await _local.getToken();
    setState(() {
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => context.pushReplacement(
        _token != null ? const MainPage() : const LoginPage(),
      ),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(96.0),
        child: Center(
          child: Assets.images.logoBlue.image(),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100.0,
        child: Align(
          alignment: Alignment.center,
          child: Assets.images.logoCwb.image(width: 96.0),
        ),
      ),
    );
  }
}

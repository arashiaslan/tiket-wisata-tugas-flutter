import 'package:flutter/material.dart';
import 'package:frontend/data/datasources/auth_local_datasource.dart';
import 'package:frontend/data/datasources/auth_remote_datasource.dart';
import 'package:frontend/data/repository/auth_repository_impl.dart';
import 'package:frontend/domain/usecases/login_usecase.dart';
import 'package:frontend/presentation/bloc/auth_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/colors.dart';
import 'presentation/ui/intro/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            LoginUseCase(
              AuthRepositoryImpl(
                AuthRemoteDatasource(),
              )
            ),
            AuthLocalDatasource(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Intensive Club batch 17',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          dialogTheme: const DialogTheme(elevation: 0),
          textTheme: GoogleFonts.outfitTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.outfit(
              color: AppColors.primary,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.black,
            ),
            centerTitle: true,
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}

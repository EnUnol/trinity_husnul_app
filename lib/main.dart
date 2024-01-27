import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/auth_cubit.dart';
import 'data/data_provider.dart';
import 'screen/home_page.dart';
import 'screen/login_signup_page.dart';
import 'screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: GetMaterialApp(
        title: 'Flutter App',
        initialRoute: '/splash',
        getPages: [
          GetPage(name: '/splash', page: () => SplashScreen()),
          GetPage(name: '/login_signup', page: () => LoginSignupPage()),
          GetPage(name: '/home', page: () => HomePage()),
        ],
      ),
    );
  }
}

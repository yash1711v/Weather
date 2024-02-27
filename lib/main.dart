import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wheather/Application/blocs/wheaher_bloc.dart';
import 'package:wheather/Application/services/FirebaeFunctionalities/auth/auth_bloc.dart';
import 'package:wheather/Presentation/Screens/HomeScreen/home_screen.dart';
import 'package:wheather/Presentation/Screens/SignupScreens/SignupScreens.dart';

import 'Application/services/FirebaeFunctionalities/auth/auth_services.dart';
import 'Application/services/wheather_services.dart';
import 'Infrastrcture/repositories.dart';
import 'Presentation/Screens/SplashScreen/SplashScreen.dart';
import 'Routes/routes.dart';
final getIt = GetIt.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureDependencies();

  runApp(const MyApp());
}
void configureDependencies() {
  getIt.registerLazySingleton(() => FirebaseAuthService());
  getIt.registerLazySingleton(() => FirebaseRepository(getIt<FirebaseAuthService>()));
  getIt.registerLazySingleton(() => WheatherService(Dio()));
  getIt.registerLazySingleton(() => WheatherRepository(getIt<WheatherService>()));
  // Register other dependencies if needed
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AuthBloc(getIt<FirebaseRepository>()),

      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
          onGenerateRoute: Routes().OnGenerateRoute,
          initialRoute: "/Initial",
        // HomeScreen(),
      ),
    );
  }
}


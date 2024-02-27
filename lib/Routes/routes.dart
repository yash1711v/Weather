import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather/Presentation/Screens/HomeScreen/home_screen.dart';
import 'package:wheather/Presentation/Screens/SignupScreens/SignupScreens.dart';
import 'package:wheather/Presentation/Screens/SplashScreen/SplashScreen.dart';

import '../Application/blocs/wheaher_bloc.dart';
import '../Application/services/FirebaeFunctionalities/auth/auth_bloc.dart';
import '../Infrastrcture/repositories.dart';
import '../main.dart';


class Routes {
  Route ? OnGenerateRoute(RouteSettings settings){
    switch (settings.name){

      case "/Initial": return MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>AuthBloc(getIt<FirebaseRepository>()),
       child: Splashscreen(),
      ));
      case "/HomeScreen": return MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>WheaherBloc(getIt<WheatherRepository>()),
       child: HomeScreen(),
      ));
      case "/LoginScreen": return MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>AuthBloc(getIt<FirebaseRepository>()),
        child: const Signupscreen(),
      ));
    }
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather/Application/services/FirebaeFunctionalities/auth/auth_bloc.dart';

import '../../../Application/blocs/wheaher_bloc.dart';
import '../../../Application/blocs/wheaher_event.dart';
import '../../../Infrastrcture/repositories.dart';
import '../../../main.dart';
import '../HomeScreen/home_screen.dart';
import '../SignupScreens/SignupScreens.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<AuthBloc>(context).add(AuthCheckRequested());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        Future.delayed(Duration(seconds: 2)).then((value) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushReplacementNamed("/HomeScreen");
            print("state $state");

          } else if (state is AuthFailure) {
            print("state $state");
            Navigator.of(context).pushReplacementNamed("/LoginScreen");
          }
        });

        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("lib/assets/Images/splashicon.png"),
                  scale: 2)),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather/Application/services/FirebaeFunctionalities/auth/auth_bloc.dart';

import '../../widgets/Dialog.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController Passcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text("SignUp", style: TextStyle(fontSize: 30),)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  String error="";
                  if (state is WrongEmailState) {
                    error = state.error;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        style: TextStyle(color: Colors.white),
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: Colors.white),
                            //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.black,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: Colors.white),
                            //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: "Enter You email",
                        ),
                        onChanged: (value) {
                          BlocProvider.of<AuthBloc>(context).add(CheckEmailEvent(email: value.trim()));
                        },
                      ),
                      Visibility(
                        visible: error.isNotEmpty ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                              error,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontFamily: 'Varta',
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  String error = '';
                  if (state is WrongPassState) {
                    error = state.error;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      TextField(
                        style: TextStyle(color: Colors.white),
                        controller: Passcontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: Colors.white),
                            //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.black,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: Colors.white),
                            //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: "Enter You Password",
                        ),
                        onChanged: (value) {
                          BlocProvider.of<AuthBloc>(context).add(CheckPassEvent(Password: value.trim()));

                        },
                      ),
                      SizedBox(height: 5,),
                      Visibility(
                        visible: error.isNotEmpty ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                              error,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontFamily: 'Varta',
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (contextt, state) {
                if (state is AuthSuccess) {

                  print("state ${state.user?.uid}");
                } else if (state is AuthFailure) {
                  print("state ${state.message}");

                } else if (state is AuthLoadingState) {
                  return Center(child: CircularProgressIndicator(),);
                }
              else  {
                  // Move the ElevatedButton outside of the BlocBuilder
                  return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(contextt).add(SignupRequested(
                          email: emailcontroller.text,
                          pass: Passcontroller.text, context: context
                      ));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Text('Sign Up'),
                  );
                };
              return Text("Change Email or password to get button ");
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:wheather/Domain/entities.dart';

import '../../../../Infrastrcture/repositories.dart';
import '../../../../Presentation/widgets/Dialog.dart';
import '../../LocalStorage/SharedPref/SharedPref.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseRepository _firebaseRepository;
  AuthBloc(this._firebaseRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckRequested) {
        LocationPermission permission;
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }else{
          _getLocation();
        }
        try {
          final user = await _firebaseRepository.checkstate();
          if(user.uid.isNotEmpty && user.uid!=null) {
            emit(AuthSuccess(user: user));
          }else{emit(AuthFailure(message: 'Authentication failed'));}
        } catch (e) {
          emit(AuthFailure(message: 'Authentication failed'));
        }

      }
      else if(event is SignupRequested){
        bool emailvalid=EmailValidator.validate(event.email);
        bool passvalid=false;
        if( event.pass.length>=8 &&  event.pass.isNotEmpty){
          passvalid=true;
        }

        emit(AuthLoadingState());
        if(emailvalid && passvalid ){
          try{
            await _firebaseRepository.login(email: event.email, pass: event.pass).then((value) async {
              final user= await _firebaseRepository.checkstate();
              if(user.uid.isNotEmpty && user.uid!=null) {

                emit(AuthSuccess(user: user));
                Navigator.of(event.context).pushReplacementNamed("/HomeScreen");
              }else{emit(AuthFailure(message: 'Authentication failed'));}


            });



          }catch(e){
            showDialog(context: event.context, builder: (context){
              return CustomDialogBox(title: "Error", content: "$e", onClosePressed: (){Navigator.pop(context);});
            });
            emit(AuthFailure(message: '${e}'));
          }
        }else{
          String content="";
          if(!emailvalid && !passvalid){
            content="Please Enter valid Password and Email address";
            showDialog(context: event.context, builder: (BuildContext context){
              return CustomDialogBox(title: "Error", content: content, onClosePressed: (){Navigator.pop(event.context);});

            });
          }else{
            if (!emailvalid) {
              content = "Please Enter Valid Email";
              emit(WrongEmailState(error: content));
            } else if (!passvalid) {
              content = "Password Must be 8 character Long";
              emit(WrongPassState(error: content));
            }
          }

        }

      }
      else if (event is SignOutRequested) {
        await _firebaseRepository.signout().then((value) {
          Navigator.of(event.context).pushReplacementNamed("/LoginScreen");

          emit(AuthFailure(message: ''));
        });


      }
    });
    on<CheckEmailEvent>((event, emit) {
      String Error="";
      bool isValid=EmailValidator.validate(event.email);
      if(isValid){

      }else{
        Error="Invalid email address";
      }
      emit(WrongEmailState(error: Error));
    });
    on<CheckPassEvent>((event, emit) {
    String Error = " ";
        if(event.Password.length>=8){
    }else{
    Error="Passowrd must be 8 character long";
    }
    emit(WrongPassState(error: Error));
    });

  }
  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        print(placemarks.first.locality);
        String cityName = placemarks.first.locality ?? 'Delhi';
        SharedPref().setCity(cityName);

      }
    } catch (e) {
      print('Error fetching location: $e');
    }
  }
  }




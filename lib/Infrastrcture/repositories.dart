import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:wheather/Application/services/FirebaeFunctionalities/auth/auth_services.dart';
import 'package:wheather/Application/services/LocalStorage/SharedPref/SharedPref.dart';

import '../Application/services/wheather_services.dart';
import '../Domain/entities.dart';

@injectable
class WheatherRepository {
  final WheatherService _wheatherService;

  WheatherRepository(this._wheatherService);

  Future<Wheather> getWeather(String city) async {
    final weatherData = await _wheatherService.fetchWeather(city);
    return Wheather(
      temperature: weatherData['main']['temp']??await SharedPref().getTempe(),
      condition: weatherData['weather'][0]['main']??await SharedPref().getCondition(),
      humidity: (weatherData['main']['humidity']??await SharedPref().getHumidity()).toString(),
      windSpeed: (weatherData['wind']['speed']??await SharedPref().getWindSpeed()).toString(),
      Name: weatherData['name'],
    );
  }
}

@injectable
class FirebaseRepository{
  final  FirebaseAuthService _firebaseAuthService;

  FirebaseRepository(this._firebaseAuthService);
   Future<void> login({required String email, required String pass})async{

      await _firebaseAuthService.signUpWithEmailAndPassword(email, pass).then((value) {
        final MyUser? user= _firebaseAuthService.checkstatus();
         return user;
      });

   }
   Future<MyUser> checkstate()async{
   
     final user = await _firebaseAuthService.checkstatus;
      print(user.call().uid);
    return MyUser(uid: user.call().uid);
   }
   Future<MyUser> signout()async{
     String Uid="";
      await _firebaseAuthService.signOut();

    return MyUser(uid: Uid);
   }

}
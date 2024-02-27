import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:wheather/Domain/entities.dart';


@injectable
class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  MyUser checkstatus(){
    MyUser Users= MyUser(uid: FirebaseAuth.instance.currentUser!.uid??"");
    if(Users.uid.isNotEmpty && Users!=null){
      return Users;
    }
    return Users;
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      checkstatus();}
      );}

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

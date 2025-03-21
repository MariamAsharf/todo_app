import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/firebase/firebase_manager.dart';
import 'package:todo_app/models/user_model.dart';

class UserProvider extends ChangeNotifier{

  UserModel? userModel;
  User? currentUser;

  UserProvider(){
    currentUser = FirebaseAuth.instance.currentUser;

    if(currentUser != null){
      initUser();
    }
  }

  initUser()async{
    currentUser = FirebaseAuth.instance.currentUser;
    userModel = await FirebaseManager.readUserData(currentUser!.uid);
    notifyListeners();
  }
}
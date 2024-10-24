import 'package:flutter/material.dart';
import 'package:job_test/core/cachehelper/cache_helper.dart';
import 'package:job_test/data/auth_repo.dart';

class AuthProvider extends ChangeNotifier{

  final AuthRepo authRepo=AuthRepo();
  GlobalKey<FormState> loginKey=GlobalKey<FormState>();
  final TextEditingController userNameController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();

  String ? _token;
  bool _isLoading=false;
  String? _errorMessage;

  String? get token=>_token;
  bool get isLoading=>_isLoading;
  bool get isLoggedIn=>_token!=null;
  String? get errorMessage=>_errorMessage;

  Future<bool> Login() async{
    _isLoading=true;
    notifyListeners();
    
    String? token= await authRepo.login(userNameController.text,passwordController.text);
    if(token!=null){
      _token=token;
      _isLoading = false;
      CacheHelper().saveData(key: 'token', value: _token);
      notifyListeners();
      return true;
    }
    else{
      _errorMessage="invalid login credentials";
      _isLoading=false;
      notifyListeners();
      return false;
    }

    
  }

  bool isPasswordSecured=true;
  IconData suffixIcon=Icons.visibility;
  void changePasswordSuffixIcon(){

    isPasswordSecured=!isPasswordSecured;
    suffixIcon=isPasswordSecured?Icons.visibility:Icons.visibility_off_sharp;
    notifyListeners();

  }


}
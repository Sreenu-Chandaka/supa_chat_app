import 'package:flutter/cupertino.dart';
import 'package:supa_chat_msg/data/extension/string_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/auth/sing_up_data.dart';
import '../../data/repository/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final repo = AuthRepository();

  bool _isLogin = false;

  bool get isLogin => _isLogin;

  void checkUserLogin() {
    _isLogin = repo.isLogin();
    notifyListeners();
  }

  ///user session data
  AuthResponse? _authResponse;
  AuthResponse get authResponse => _authResponse ?? AuthResponse();

  void onSignUp({required Function() success, required Function() failure}) async {
    if(!_singUpData.email.validEmail() || singUpData.isNull()){

      return;
    }

    final response = await repo.onSingUpWithEmailPassword(_singUpData);
    if (response.user?.email == null) {
      failure();

      return;
    }
    ///first login after create account
    final mResponse = await repo.onSingIn(_singUpData);

    ///save user info data
    repo.onSaveUserInfo(response.user!, username: _singUpData.username);
    _authResponse = mResponse;
    _singUpData = SingUpData();
    notifyListeners();

    success();
    print(success());
    print("sucesss.........................///////////////////");
  }

  void onCheckScreenAuth({required Function() auth,required Function() unAuth}){
    checkUserLogin();
    if(_isLogin){
      auth();
    }else {
      unAuth();
    }
  }

  ///sing up data
  SingUpData _singUpData = SingUpData();
  SingUpData get singUpData => _singUpData;

  void onUserNameChange(String? it){
    if(it != null){
      _singUpData.username = it;
      notifyListeners();
    }
  }

  void onEmailChange(String? it){
    if(it != null){
      _singUpData.email = it;
      notifyListeners();
    }
  }

  void onPasswordChange(String? it){
    if(it != null){
      debugPrint("password change $it");
      _singUpData.password = it;
      notifyListeners();
    }
  }

  void onSignIn({required Function() success,required Function() failure}) async {
    if(_singUpData.password == "" || _singUpData.email == ""){
      debugPrint("password null ${_singUpData.password} :${_singUpData.email}");
      return;
    }

    debugPrint('starting login');
    try {
      final response = await repo.onSingIn(_singUpData);
      if(response.user == null){
        failure();

        return;
      }
  
      success();
      
    
    }
    catch(err){
      debugPrint('login error :$err');
      failure();
    }

    notifyListeners();

  }

}

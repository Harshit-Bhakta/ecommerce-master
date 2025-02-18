import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController{
  static String accessToken='';

  static const _key='token';

  static Future<void> setToken(String token)async{
    log(token);
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString(_key, token);
    accessToken=token;
  }

  static Future<String> getToken()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    accessToken=sharedPreferences.getString(_key)??'';
    return accessToken;
  }

  static Future<bool> isLoggedIn()async{
    try{
      String token = await getToken();
      return token.isNotEmpty;
    }catch(e){
      log(e.toString());
      return false;
    }
  }

  static Future<void> deleteData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken='';
  }
}
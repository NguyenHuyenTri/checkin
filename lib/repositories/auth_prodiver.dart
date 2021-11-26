import 'dart:async';
import 'dart:convert';
import 'package:vao_ra/helpers/dioultibaohq.dart';
import 'package:vao_ra/helpers/ulti.dart';
import 'package:vao_ra/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider {

  AuthProvider() {
    DioUtilBaohq.tokenInter();
  }

  Future<M5500EmployeeModel> authWithToken() async {
    try {
      var map = new Map<String, dynamic>();
      final response = await DioUtilBaohq.postLogin("", map);
      Map<String, dynamic> res = jsonDecode(response.toString());

      if (res['error'] != null) {
        throw Exception(res['error']);
      } else {
        return M5500EmployeeModel.fromJson(res['profile']);
      }
    } catch (e) {
      print("AuthProvider authWithToken $e");
      return null;
    }
  }

  Future<M5500EmployeeModel> signInWithUsernamePassword(String username, String password ) async {
    try {

      print('Call M5500EmployeeModel signInWithUsernamePassword');
      var map = new Map<String, dynamic>();
      if( username != null){
        map['Email'] = username;
      }
      if( password != null && password.length > 1){
        map['Password'] = password;
      }
      map['what'] = 5507;
      print('Call M5500EmployeeModel signInWithUsernamePassword map ${map}');
      print('Call M5500EmployeeModel signInWithUsernamePassword BASE_URL_API ${Ulti.BASE_URL_API}');
      final response = await DioUtilBaohq.postLogin("", map);

      print('Call M5500EmployeeModel signInWithUsernamePassword response ${response}');
      Map<String, dynamic> res = jsonDecode(response.toString());

      print('Call M5500EmployeeModel signInWithUsernamePassword res ${res}');
      if (res['error'] != null && res['error'].toString().length > 0) {
        throw Exception(res['error']);
      } else if (res['data'] == null || res['data'][0] == null) {
        throw Exception("User not found");
      } else {
        print('Precall M5500EmployeeModel.fromJson ${res['data']}');
        return  M5500EmployeeModel.fromJson(res['data'][0]);
      }
    } catch (e) {
      print("AuthProvider signInWithUsernamePassword $e");
      throw e;
    }
  }

  Future<M5500EmployeeModel> getCurrentUser() async {
    try {
      print('Call this M5500EmployeeModel getCurrentUser');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String user = prefs.getString("user");
      print('Call this M5500EmployeeModel user ${user}');
      if(user == null || user == "") return null;
      Map<String, dynamic> res = jsonDecode(user.toString());
      if (res['error'] != null) {
        throw Exception(res['error']);
      } else {
        return  M5500EmployeeModel.fromJson(res);
      }
    } catch (e) {
      print("AuthProvider getCurrentUser $e");
      throw e;
    }
  }

  Future<M3400CompanyModel> getCurrentCompany() async {
    try {
      print('Call this M5500EmployeeModel getCurrentCompany');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String company = prefs.getString("company");
      print('Call this M5500EmployeeModel company ${company}');
      if(company == null || company == "") return null;
      Map<String, dynamic> res = jsonDecode(company.toString());
      if (res['error'] != null) {
        throw Exception(res['error']);
      } else {
        return  M3400CompanyModel.fromJson(res);
      }
    } catch (e) {
      print("AuthProvider getCurrentCompany $e");
      throw e;
    }
  }

  Future<String> getCurrentToken() async {
    try {
      print('Call this M5500EmployeeModel getCurrentToken');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String loginToken = prefs.getString("loginToken");
      print('Call this M5500EmployeeModel loginToken ${loginToken}');
      if(loginToken == null || loginToken == "") return null;
      return  loginToken;
    } catch (e) {
      print("AuthProvider getCurrentCompany $e");
      throw e;
    }
  }

  Future<M3400CompanyModel> setCurrentCompany(M3400CompanyModel company) async {
    try {
      print('Call this M5500EmployeeModel setCurrentCompany ${company.toJson().toString()}');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('company', company.toJson().toString());
    } catch (e) {
      print("AuthProvider getCurrentUser $e");
      throw e;
    }
  }

  Future<dynamic> updateFCMToken(String token) async {
    try {
      var map = new Map<String, dynamic>();
      map['fcmToken'] = token;
      final response = await DioUtilBaohq.post("users/me", map);
      Map<String, dynamic> res = jsonDecode(response.toString());
      if (res['error'] != null) {
        throw Exception(res['error']);
      } else {
        return res;
      }
    } catch (e) {
      throw e;
    }
  }

  // Future<void> deleteToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('loginToken', "");
  //   return;
  // }

  Future<void> persistToken(String token) async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  @override
  Future<void> signOut() {
    return null;
  }

// Future<User> authDevice(String deviceId) async {
//   try {
//     var map = new Map<String, dynamic>();
//     map['deviceId'] = deviceId;
//     final response = await DioUtil.callPOSTAPI("auth/device", map);
//     Map<String, dynamic> res = jsonDecode(response.toString());
//     if (res['error'] != null) {
//       throw Exception(res['error']);
//     } else {
//       return  User.fromJson(res['data']['user']['data']);
//     }
//   } catch (e) {
//     throw e;
//   }
// }

// Future<User> authApple(User user) async {
//   try {
//     var map = new Map<String, dynamic>();
//     if(user.email != null){
//       map['email'] = user.email;
//     }
//     if(user.name != null && user.name.length > 1){
//       map['name'] = user.name;
//     }
//     if(user.avatar != null){
//       map['avatar'] = user.avatar;
//     }
//     map['identityToken'] = user.identityToken;
//     final response = await DioUtil.callPOSTAPI("auth/apple", map);
//     Map<String, dynamic> res = jsonDecode(response.toString());
//     print(res);
//     if (res['error'] != null) {
//       throw Exception(res['error']);
//     } else {
//       return  User.fromJson(res['data']['user']['data']);
//     }
//   } catch (e) {
//     print("UserApiProvider authFacebook $e");
//     throw e;
//   }
// }

// Future<User> deleteAccount() async {
//   try {
//     final response = await DioUtil.get("users/me/delete");
//     Map<String, dynamic> res = jsonDecode(response.toString());
//     if (res['error'] != null) {
//       throw Exception(res['error']);
//     } else {
//       if(res['data']['user']['data'] == null) throw Exception('User not found');
//       return User.fromJson(res['data']['user']['data']);
//     }
//   } catch (e) {
//     print("UserApiProvider checkPremiumStatus $e");
//     throw e;
//   }
// }

}

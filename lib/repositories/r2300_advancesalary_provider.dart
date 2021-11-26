import 'dart:convert';

import 'package:vao_ra/helpers/dioultibaohq.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
import '../helpers/dioulti.dart';

class R2300AdvanceSalaryProvider {
  /**
   * R2300AdvanceSalaryProvider
   */
  R2300AdvanceSalaryProvider() {
    DioUtilBaohq.tokenInter();
  }

  /**
   *
   */
  Future<dynamic> p2300AdvanceSalary(
      int what, Map<String, dynamic> param) async {
    param['what'] = what;

    switch (what) {
      // Get all data from AdvanceSalary
      case 2300:
        try {
          final response = await DioUtil.callPOSTAPI(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return result['data'];
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Insert data to AdvanceSalary
      case 2301:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return true;
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          print("AuthenticationService authWithToken $e");
          throw e;
        }
        break;

      // Update data AdvanceSalary
      case 2302:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M2300AdvanceSalaryModel>.from(result['data']
                .map((model) => M2300AdvanceSalaryModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Delete data of AdvanceSalary
      case 2303:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M2300AdvanceSalaryModel>.from(result['data']
                .map((model) => M2300AdvanceSalaryModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Find data with id AdvanceSalary
      case 2304:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M2300AdvanceSalaryModel>.from(result['data']
                .map((model) => M2300AdvanceSalaryModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Select with pagination(offset, number-item-in-page) AdvanceSalary
      case 2305:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M2300AdvanceSalaryModel>.from(result['data']
                .map((model) => M2300AdvanceSalaryModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Count number item of AdvanceSalary
//      case 2306:
//        try {
//          final response = await DioUtil.post(param);
//          Map<String, dynamic> result = jsonDecode(response.toString());
//          if (result['status'] == true) {
//            return result;
//          } else {
//            throw Exception(result['error']);
//          }
//        } catch (e) {
//          throw e;
//        }
//        break;

      case 2307:
        try {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          final response = await DioUtilBaohq.post('', param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          print(preferences.getString('loginToken'));
          if (result['status'] == true) {
            return result['data'];
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      case 2308:
        try {
          print('2308 ${param}');
          SharedPreferences preferences = await SharedPreferences.getInstance();
          final response = await DioUtilBaohq.post('', param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          print(preferences.getString('loginToken'));
          print('result 2308 ${result}');
          if (result['advance_salary']['status'] == true &&
              result['overtime']['status'] == true &&
              result['business_trip']['status'] == true &&
              result['on_leave']['status'] == true &&
              result['checkin_late']['status'] == true &&
              result['checkout_soon']['status'] == true) {
            return result;
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Count number item of AdvanceSalary
      case 2309:
        try {
          final response = await DioUtil.post(param);
          print('2309 ${param}');
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['advance_salary_wait_approve']['status'] == true ||
              result['overtime_wait_approve']['status'] == true ||
              result['business_trip_wait_approve']['status'] == true ||
              result['checkin_late_wait_approve']['status'] == true ||
              result['checkout_soon_wait_approve']['status'] == true ||
              result['on_leave_wait_approve']['status'] == true ||

              result['advance_salary_approved']['status'] == true ||
              result['overtime_approved']['status'] == true ||
              result['checkin_late_approved']['status'] == true ||
              result['checkout_soon_approved']['status'] == true ||
              result['on_leave_approved']['status'] == true ||

              result['advance_salary_denied']['status'] == true ||
              result['overtime_denied']['status'] == true ||
              result['checkin_late_denied']['status'] == true ||
              result['checkout_soon_denied']['status'] == true ||
              result['on_leave_denied']['status'] == true) {
            return result;
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // get all data requests approved
      case 2310:
        try {
          final response = await DioUtilBaohq.post('', param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['advance_salary']['status'] == true &&
              result['overtime']['status'] == true &&
              result['on_leave']['status'] == true &&
              result['checkin_late']['status'] == true &&
              result['checkout_soon']['status'] == true) {
            print('Start call 2310 statement : ' + result.toString());
            return result;
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

    // get all data requests denied
      case 2311:
        try {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          final response = await DioUtilBaohq.post('', param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          print(preferences.getString('loginToken'));
          if (result['advance_salary']['status'] == true &&
              result['overtime']['status'] == true &&
              result['on_leave']['status'] == true &&
              result['checkin_late']['status'] == true &&
              result['checkout_soon']['status'] == true) {
            print('Start call 2311 statement : ' + result.toString());
            return result;
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;


    // get all data to detail
      case 2313:
        try {
          final response = await DioUtilBaohq.post('', param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            print('Break point 2313 statement : ' + result.toString());
            return result['data'];
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      default:
        {
          //statements;
        }
        break;
    }
  }
}

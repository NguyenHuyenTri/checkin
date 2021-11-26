import 'dart:convert';

import '../models/models.dart';
import '../helpers/dioulti.dart';

class R1800OvertimeProvider {
  /**
   * R1800OvertimeProvider
   */
  R1800OvertimeProvider() {
    DioUtil.tokenInter();
  }

  /**
   *
   */
  Future<dynamic> p1800Overtime(int what, Map<String, dynamic> param) async {
    param['what'] = what;

    switch (what) {
      // Get all data from Overtime
      case 1800:
        try {
          final response = await DioUtil.callPOSTAPI(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M1800OvertimeModel>.from(result['data']
                .map((model) => M1800OvertimeModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // insert data overtime
      case 1801:
        try {
          final response = await DioUtil.callPOSTAPI(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return true;
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Insert data to Overtime
      case 1801:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M1800OvertimeModel>.from(result['data']
                .map((model) => M1800OvertimeModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          print("AuthenticationService authWithToken $e");
          throw e;
        }
        break;

      // Update data Overtime
      case 1802:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M1800OvertimeModel>.from(result['data']
                .map((model) => M1800OvertimeModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Delete data of Overtime
      case 1803:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M1800OvertimeModel>.from(result['data']
                .map((model) => M1800OvertimeModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Find data with id Overtime
      case 1804:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M1800OvertimeModel>.from(result['data']
                .map((model) => M1800OvertimeModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Select with pagination(offset, number-item-in-page) Overtime
      case 1805:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M1800OvertimeModel>.from(result['data']
                .map((model) => M1800OvertimeModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Count number item of Overtime
      case 1806:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M1800OvertimeModel>.from(result['data']
                .map((model) => M1800OvertimeModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Count number item of Overtime
//      case 1808:
//        try {
//          final response = await DioUtil.post(param);
//          Map<String, dynamic> result = jsonDecode(response.toString());
//          if (result['status'] == true) {
//            print('Call 1808 statement: ' + result.toString());
//            return result;
//          } else {
//            throw Exception(result['error']);
//          }
//        } catch (e) {
//          throw e;
//        }
//        break;
      case 1813:
        try {
          final response = await DioUtil.post(param);
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
      default:
        {
          //statements;
        }
        break;
    }
  }
}

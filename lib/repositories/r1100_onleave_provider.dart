import 'dart:convert';

import '../models/models.dart';
import '../helpers/dioulti.dart';

class R1100OnLeaveProvider {
  /**
   * R1100OnLeaveProvider
   */
  R1100OnLeaveProvider() {
    DioUtil.tokenInter();
  }

  /**
   *
   */
  Future<dynamic> p1100OnLeave(int what, Map<String, dynamic> param) async {
    param['what'] = what;

    switch (what) {
      // Get all data from OnLeave
      case 1100:
        try {
          final response = await DioUtil.callPOSTAPI(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M1100OnLeaveModel>.from(result['data']
                .map((model) => M1100OnLeaveModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Insert data OnLeave on database
      // DatNQ
      case 1101:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return result;
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          print("AuthenticationService authWithToken $e");
          throw e;
        }
        break;

      // Update data OnLeave
      case 1102:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M1100OnLeaveModel>.from(result['data']
                .map((model) => M1100OnLeaveModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Delete data of OnLeave
      case 1103:
        try {
          final response = await DioUtil.post(param);
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

      // Find data with id OnLeave
      case 1104:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M1100OnLeaveModel>.from(result['data']
                .map((model) => M1100OnLeaveModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Select with pagination(offset, number-item-in-page) OnLeave
      case 1105:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M1100OnLeaveModel>.from(result['data']
                .map((model) => M1100OnLeaveModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Count number item of OnLeave
      case 1106:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M1100OnLeaveModel>.from(result['data']
                .map((model) => M1100OnLeaveModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

    // Dem so ngay nghi phep & so ngay nghi tieu chuan
      case 1108:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['not_have_on_leave']['status'] == true ||
              result['standard_on_leave']['status'] == true) {
            print('Call 1108 statement ' + result.toString());
            return result;
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

    // lay data nghi phep de ra chi tiet
      case 1115:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            print('Break point 1115 provider ' + result.toString());
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

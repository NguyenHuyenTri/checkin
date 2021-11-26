import 'dart:convert';

import '../models/models.dart';
import '../helpers/dioulti.dart';

class R3400CompanyProvider {
  /**
   * R3400CompanyProvider
   */
  R3400CompanyProvider() {
    DioUtil.tokenInter();
  }

  /**
   *
   */
  Future<dynamic> p3400Company(int what, Map<String, dynamic> param) async {
    param['what'] = what;

    switch (what) {
      // Get all data from Company
      case 3400:
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

      // Insert data to Company
      case 3401:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3400CompanyModel>.from(result['data']
                .map((model) => M3400CompanyModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          print("AuthenticationService authWithToken $e");
          throw e;
        }
        break;

      // Update data Company
      case 3402:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3400CompanyModel>.from(result['data']
                .map((model) => M3400CompanyModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Delete data of Company
      case 3403:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3400CompanyModel>.from(result['data']
                .map((model) => M3400CompanyModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Find data with id Company
      case 3404:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3400CompanyModel>.from(result['data']
                .map((model) => M3400CompanyModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Select with pagination(offset, number-item-in-page) Company
      case 3405:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3400CompanyModel>.from(result['data']
                .map((model) => M3400CompanyModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Count number item of Company
      case 3406:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3400CompanyModel>.from(result['data']
                .map((model) => M3400CompanyModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;
      // Get data from Company
      case 3407:
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
      default:
        {
          //statements;
        }
        break;
    }
  }
}

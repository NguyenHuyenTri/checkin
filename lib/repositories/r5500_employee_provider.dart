import 'dart:convert';
import 'dart:io';

import 'package:vao_ra/helpers/dioultibaohq.dart';

import '../models/models.dart';
import '../helpers/dioulti.dart';

class R5500EmployeeProvider {
  /**
   * R5500EmployeeProvider
   */
  R5500EmployeeProvider() {
    DioUtilBaohq.tokenInter();
  }


  /**
   *
   */
  Future<dynamic> p5500Employee(int what, Map<String, dynamic> param) async {
    param['what'] = what;

    switch (what) {
      // Get all data from Employee


      // Insert data to Employee
      case 5501:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return result['status'];
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          print("AuthenticationService authWithToken $e");
          throw e;
        }
        break;

      // Update data Employee
      case 5502:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M5500EmployeeModel>.from(result['data']
                .map((model) => M5500EmployeeModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Delete data of Employee
      case 5503:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M5500EmployeeModel>.from(result['data']
                .map((model) => M5500EmployeeModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Find data with id Employee
      case 5504:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M5500EmployeeModel>.from(result['data']
                .map((model) => M5500EmployeeModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Select with pagination(offset, number-item-in-page) Employee
      case 5505:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M5500EmployeeModel>.from(result['data']
                .map((model) => M5500EmployeeModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Count number item of Employee
      case 5506:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M5500EmployeeModel>.from(result['data']
                .map((model) => M5500EmployeeModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Select with IdCompany, email, password
      case 5507:
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
      case 5510:
        try {
          final response = await DioUtil.callPOSTAPI(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            print(result['status'].toString());
            return result['data'];
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }

        break;

      case 5511:
        try {
          final response = await DioUtil.callPOSTAPI(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return result['status'];
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;
      case 5512:
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

      case 5513:
        try {
          final response = await DioUtil.callPOSTAPI(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            print(result['status'].toString());
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

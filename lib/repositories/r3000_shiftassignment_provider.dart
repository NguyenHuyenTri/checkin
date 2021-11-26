import 'dart:convert';

import '../models/models.dart';
import '../helpers/dioulti.dart';

class R3000ShiftAssignmentProvider {
  /**
   * R3000ShiftAssignmentProvider
   */
  R3000ShiftAssignmentProvider() {
    DioUtil.tokenInter();
  }

  /**
   *
   */
  Future<dynamic> p3000ShiftAssignment(
      int what, Map<String, dynamic> param) async {
    param['what'] = what;

    switch (what) {
      // Get all data from ShiftAssignment
      case 3000:
        try {
          final response = await DioUtil.callPOSTAPI(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3000ShiftAssignmentModel>.from(result['data']
                .map((model) => M3000ShiftAssignmentModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Insert data to ShiftAssignment
      case 3001:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3000ShiftAssignmentModel>.from(result['data']
                .map((model) => M3000ShiftAssignmentModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          print("AuthenticationService authWithToken $e");
          throw e;
        }
        break;

      // Update data ShiftAssignment
      case 3002:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3000ShiftAssignmentModel>.from(result['data']
                .map((model) => M3000ShiftAssignmentModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Delete data of ShiftAssignment
      case 3003:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3000ShiftAssignmentModel>.from(result['data']
                .map((model) => M3000ShiftAssignmentModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Find data with id ShiftAssignment
      case 3004:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3000ShiftAssignmentModel>.from(result['data']
                .map((model) => M3000ShiftAssignmentModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Select with pagination(offset, number-item-in-page) ShiftAssignment
      case 3005:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3000ShiftAssignmentModel>.from(result['data']
                .map((model) => M3000ShiftAssignmentModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Count number item of ShiftAssignment
      case 3006:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3000ShiftAssignmentModel>.from(result['data']
                .map((model) => M3000ShiftAssignmentModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

      // Count number item of ShiftAssignment
      case 3007:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M3000ShiftAssignmentModel>.from(result['data']
                .map((model) => M3000ShiftAssignmentModel.fromJson(model)));
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

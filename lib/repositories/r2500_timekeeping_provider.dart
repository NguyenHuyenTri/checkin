import 'dart:convert';                                                                                               
																													   
import '../models/models.dart';                                                                                      
import '../helpers/dioulti.dart';                                                                                     
																													   
class R2500TimekeepingProvider {                                                                  
  /**                                                                                                                  
   * R2500TimekeepingProvider                                                                     
   */                                                                                                                  
  R2500TimekeepingProvider() {                                                                    
    DioUtil.tokenInter();                                                                                              
  }                                                                                                                    
																													   
  /**                                                                                                                  
   *                                                                                                                   
   */                                                                                                                  
  Future<dynamic> p2500Timekeeping(int what, Map<String, dynamic> param) async {                  
																													   
    param['what'] = what;                                                                                            
																													   
    switch (what) {                                                                                                    
    // Get all data from Timekeeping                                                                        
      case 2500:                                                                                             
        try {                                                                                                          
          final response = await DioUtil.callPOSTAPI(param);
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M2500TimekeepingModel>.from(                                              
                result['data'].map((model) => M2500TimekeepingModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Insert data to Timekeeping                                                                           
      case 2501:                                                                                           
        try {
          print('vao duoc toi day 2501');
          print('param 2501 ${param}');
          final response = await DioUtil.post(param);
          print('response 2501 ${response}');
          Map<String, dynamic> result = jsonDecode(response.toString());

          print('result 2501 ${result}');
          if (result['status'] == true) {
            return List<M2500TimekeepingModel>.from(                                              
                result['data'].map((model) => M2500TimekeepingModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          print("p2500Timekeeping 2501 $e");
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Update data Timekeeping                                                                              
      case 2502:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M2500TimekeepingModel>.from(                                              
                result['data'].map((model) => M2500TimekeepingModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Delete data of Timekeeping                                                                           
      case 2503:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M2500TimekeepingModel>.from(                                              
                result['data'].map((model) => M2500TimekeepingModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Find data with id Timekeeping                                                                        
      case 2504:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M2500TimekeepingModel>.from(                                              
                result['data'].map((model) => M2500TimekeepingModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Select with pagination(offset, number-item-in-page) Timekeeping                                      
      case 2505:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M2500TimekeepingModel>.from(                                              
                result['data'].map((model) => M2500TimekeepingModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Count number item of Timekeeping                                                                     
      case 2506:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M2500TimekeepingModel>.from(                                              
                result['data'].map((model) => M2500TimekeepingModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         

    // Count number item of Timekeeping
      case 2507:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            return List<M2500TimekeepingModel>.from(
                result['data'].map((model) => M2500TimekeepingModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

    // Checkout normal
      case 2508:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());

          print('result 2508 ${result}');
          if (result['status'] == true) {
            return List<M2500TimekeepingModel>.from(
                result['data'].map((model) => M2500TimekeepingModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

    // Checkout face
      case 2509:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());

          print('result 2509 ${result}');
          if (result['status'] == true) {
            return List<M2500TimekeepingModel>.from(
                result['data'].map((model) => M2500TimekeepingModel.fromJson(model)));
          } else {
            throw Exception(result['error']);
          }
        } catch (e) {
          throw e;
        }
        break;

    // get data Timekeeping
      case 2510:
        try {
          final response = await DioUtil.post(param);
          Map<String, dynamic> result = jsonDecode(response.toString());
          if (result['status'] == true) {
            print('Call 2510 statement : ' + result.toString());
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

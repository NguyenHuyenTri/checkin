import 'dart:convert';                                                                                               
																													   
import '../models/models.dart';                                                                                      
import '../helpers/dioulti.dart';                                                                                     
																													   
class R4500PayrollProvider {                                                                  
  /**                                                                                                                  
   * R4500PayrollProvider                                                                     
   */                                                                                                                  
  R4500PayrollProvider() {                                                                    
    DioUtil.tokenInter();                                                                                              
  }                                                                                                                    
																													   
  /**                                                                                                                  
   *                                                                                                                   
   */                                                                                                                  
  Future<dynamic> p4500Payroll(int what, Map<String, dynamic> param) async {                  
																													   
    param['what'] = what;                                                                                            
																													   
    switch (what) {                                                                                                    
    // Get all data from Payroll                                                                        
      case 4500:                                                                                             
        try {                                                                                                          
          final response = await DioUtil.callPOSTAPI(param);
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M4500PayrollModel>.from(                                              
                result['data'].map((model) => M4500PayrollModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Insert data to Payroll                                                                           
      case 4501:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M4500PayrollModel>.from(                                              
                result['data'].map((model) => M4500PayrollModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          print("AuthenticationService authWithToken $e");                                                             
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Update data Payroll                                                                              
      case 4502:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M4500PayrollModel>.from(                                              
                result['data'].map((model) => M4500PayrollModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Delete data of Payroll                                                                           
      case 4503:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M4500PayrollModel>.from(                                              
                result['data'].map((model) => M4500PayrollModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Find data with id Payroll                                                                        
      case 4504:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M4500PayrollModel>.from(                                              
                result['data'].map((model) => M4500PayrollModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Select with pagination(offset, number-item-in-page) Payroll                                      
      case 4505:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M4500PayrollModel>.from(                                              
                result['data'].map((model) => M4500PayrollModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Count number item of Payroll                                                                     
      case 4506:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M4500PayrollModel>.from(                                              
                result['data'].map((model) => M4500PayrollModel.fromJson(model)));          
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

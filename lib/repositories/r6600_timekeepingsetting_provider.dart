import 'dart:convert';                                                                                               
																													   
import '../models/models.dart';                                                                                      
import '../helpers/dioulti.dart';                                                                                     
																													   
class R6600TimeKeepingSettingProvider {                                                                  
  /**                                                                                                                  
   * R6600TimeKeepingSettingProvider                                                                     
   */                                                                                                                  
  R6600TimeKeepingSettingProvider() {                                                                    
    DioUtil.tokenInter();                                                                                              
  }                                                                                                                    
																													   
  /**                                                                                                                  
   *                                                                                                                   
   */                                                                                                                  
  Future<dynamic> p6600TimeKeepingSetting(int what, Map<String, dynamic> param) async {                  
																													   
    param['what'] = what;                                                                                            
																													   
    switch (what) {                                                                                                    
    // Get all data from TimeKeepingSetting                                                                        
      case 6600:                                                                                             
        try {                                                                                                          
          final response = await DioUtil.callPOSTAPI(param);
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M6600TimeKeepingSettingModel>.from(                                              
                result['data'].map((model) => M6600TimeKeepingSettingModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Insert data to TimeKeepingSetting                                                                           
      case 6601:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M6600TimeKeepingSettingModel>.from(                                              
                result['data'].map((model) => M6600TimeKeepingSettingModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          print("AuthenticationService authWithToken $e");                                                             
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Update data TimeKeepingSetting                                                                              
      case 6602:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M6600TimeKeepingSettingModel>.from(                                              
                result['data'].map((model) => M6600TimeKeepingSettingModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Delete data of TimeKeepingSetting                                                                           
      case 6603:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M6600TimeKeepingSettingModel>.from(                                              
                result['data'].map((model) => M6600TimeKeepingSettingModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Find data with id TimeKeepingSetting                                                                        
      case 6604:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M6600TimeKeepingSettingModel>.from(                                              
                result['data'].map((model) => M6600TimeKeepingSettingModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Select with pagination(offset, number-item-in-page) TimeKeepingSetting                                      
      case 6605:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M6600TimeKeepingSettingModel>.from(                                              
                result['data'].map((model) => M6600TimeKeepingSettingModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Count number item of TimeKeepingSetting                                                                     
      case 6606:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M6600TimeKeepingSettingModel>.from(                                              
                result['data'].map((model) => M6600TimeKeepingSettingModel.fromJson(model)));          
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

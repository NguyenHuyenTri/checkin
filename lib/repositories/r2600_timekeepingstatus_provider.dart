import 'dart:convert';                                                                                               
																													   
import '../models/models.dart';                                                                                      
import '../helpers/dioulti.dart';                                                                                     
																													   
class R2600TimekeepingStatusProvider {                                                                  
  /**                                                                                                                  
   * R2600TimekeepingStatusProvider                                                                     
   */                                                                                                                  
  R2600TimekeepingStatusProvider() {                                                                    
    DioUtil.tokenInter();                                                                                              
  }                                                                                                                    
																													   
  /**                                                                                                                  
   *                                                                                                                   
   */                                                                                                                  
  Future<dynamic> p2600TimekeepingStatus(int what, Map<String, dynamic> param) async {                  
																													   
    param['what'] = what;                                                                                            
																													   
    switch (what) {                                                                                                    
    // Get all data from TimekeepingStatus                                                                        
      case 2600:                                                                                             
        try {                                                                                                          
          final response = await DioUtil.callPOSTAPI(param);
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M2600TimekeepingStatusModel>.from(                                              
                result['data'].map((model) => M2600TimekeepingStatusModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Insert data to TimekeepingStatus                                                                           
      case 2601:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M2600TimekeepingStatusModel>.from(                                              
                result['data'].map((model) => M2600TimekeepingStatusModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          print("AuthenticationService authWithToken $e");                                                             
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Update data TimekeepingStatus                                                                              
      case 2602:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M2600TimekeepingStatusModel>.from(                                              
                result['data'].map((model) => M2600TimekeepingStatusModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Delete data of TimekeepingStatus                                                                           
      case 2603:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M2600TimekeepingStatusModel>.from(                                              
                result['data'].map((model) => M2600TimekeepingStatusModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Find data with id TimekeepingStatus                                                                        
      case 2604:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M2600TimekeepingStatusModel>.from(                                              
                result['data'].map((model) => M2600TimekeepingStatusModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Select with pagination(offset, number-item-in-page) TimekeepingStatus                                      
      case 2605:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M2600TimekeepingStatusModel>.from(                                              
                result['data'].map((model) => M2600TimekeepingStatusModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Count number item of TimekeepingStatus                                                                     
      case 2606:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M2600TimekeepingStatusModel>.from(                                              
                result['data'].map((model) => M2600TimekeepingStatusModel.fromJson(model)));          
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

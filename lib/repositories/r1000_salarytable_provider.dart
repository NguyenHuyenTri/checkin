import 'dart:convert';                                                                                               
																													   
import '../models/models.dart';                                                                                      
import '../helpers/dioulti.dart';                                                                                     
																													   
class R1000SalaryTableProvider {                                                                  
  /**                                                                                                                  
   * R1000SalaryTableProvider                                                                     
   */                                                                                                                  
  R1000SalaryTableProvider() {                                                                    
    DioUtil.tokenInter();                                                                                              
  }                                                                                                                    
																													   
  /**                                                                                                                  
   *                                                                                                                   
   */                                                                                                                  
  Future<dynamic> p1000SalaryTable(int what, Map<String, dynamic> param) async {                  
																													   
    param['what'] = what;                                                                                            
																													   
    switch (what) {                                                                                                    
    // Get all data from SalaryTable                                                                        
      case 1000:                                                                                             
        try {                                                                                                          
          final response = await DioUtil.callPOSTAPI(param);
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M1000SalaryTableModel>.from(                                              
                result['data'].map((model) => M1000SalaryTableModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Insert data to SalaryTable                                                                           
      case 1001:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M1000SalaryTableModel>.from(                                              
                result['data'].map((model) => M1000SalaryTableModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          print("AuthenticationService authWithToken $e");                                                             
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Update data SalaryTable                                                                              
      case 1002:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M1000SalaryTableModel>.from(                                              
                result['data'].map((model) => M1000SalaryTableModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Delete data of SalaryTable                                                                           
      case 1003:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M1000SalaryTableModel>.from(                                              
                result['data'].map((model) => M1000SalaryTableModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Find data with id SalaryTable                                                                        
      case 1004:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M1000SalaryTableModel>.from(                                              
                result['data'].map((model) => M1000SalaryTableModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Select with pagination(offset, number-item-in-page) SalaryTable                                      
      case 1005:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M1000SalaryTableModel>.from(                                              
                result['data'].map((model) => M1000SalaryTableModel.fromJson(model)));          
          } else {                                                                                                     
            throw Exception(result['error']);                                                                        
          }                                                                                                            
        } catch (e) {                                                                                                  
          throw e;                                                                                                     
        }                                                                                                              
        break;                                                                                                         
																													   
    // Count number item of SalaryTable                                                                     
      case 1006:                                                                                           
        try {                                                                                                          
          final response = await DioUtil.post(param);                                                                  
          Map<String, dynamic> result = jsonDecode(response.toString());                                               
          if (result['status'] == true) {                                                                            
            return List<M1000SalaryTableModel>.from(                                              
                result['data'].map((model) => M1000SalaryTableModel.fromJson(model)));          
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

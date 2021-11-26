import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class EmployeeActiveBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 5600                                                                                                                                                                  
  List<M5600EmployeeActiveModel> _listEmployeeActive5600 = [];                                                                                      
  final _employeeActiveSubject5600 = PublishSubject<List<M5600EmployeeActiveModel>>();                                                        
  Stream<List<M5600EmployeeActiveModel>> get employeeActiveStream5600 => _employeeActiveSubject5600.stream;       
																																																
  // for what 5605                                                                                                                                                                
  List<M5600EmployeeActiveModel> _listEmployeeActive5605 = [];                                                                                    
  final _employeeActiveSubject5605 = PublishSubject<List<M5600EmployeeActiveModel>>();                                                      
  Stream<List<M5600EmployeeActiveModel>> get employeeActiveStream5605 => _employeeActiveSubject5605.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _employeeActiveSubject5600.close();                                                                                                                             
    _employeeActiveSubject5605.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5600 get all data EmployeeActive                                                                                                                             
   */                                                                                                                                                                                           
  callWhat5600() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 5600;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listEmployeeActive5600.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listEmployeeActive5600 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _employeeActiveSubject5600.sink.add(_listEmployeeActive5600);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5605 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat5605(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 5605;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listEmployeeActive5605 = [];                                                                                                                               
            _listEmployeeActive5605.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listEmployeeActive5605.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _employeeActiveSubject5605.sink.add(_listEmployeeActive5605);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

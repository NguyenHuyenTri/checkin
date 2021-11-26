import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class DepartmentBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 5900                                                                                                                                                                  
  List<M5900DepartmentModel> _listDepartment5900 = [];                                                                                      
  final _departmentSubject5900 = PublishSubject<List<M5900DepartmentModel>>();                                                        
  Stream<List<M5900DepartmentModel>> get departmentStream5900 => _departmentSubject5900.stream;       
																																																
  // for what 5905                                                                                                                                                                
  List<M5900DepartmentModel> _listDepartment5905 = [];                                                                                    
  final _departmentSubject5905 = PublishSubject<List<M5900DepartmentModel>>();                                                      
  Stream<List<M5900DepartmentModel>> get departmentStream5905 => _departmentSubject5905.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _departmentSubject5900.close();                                                                                                                             
    _departmentSubject5905.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5900 get all data Department                                                                                                                             
   */                                                                                                                                                                                           
  callWhat5900() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 5900;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listDepartment5900.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listDepartment5900 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _departmentSubject5900.sink.add(_listDepartment5900);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5905 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat5905(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 5905;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listDepartment5905 = [];                                                                                                                               
            _listDepartment5905.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listDepartment5905.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _departmentSubject5905.sink.add(_listDepartment5905);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

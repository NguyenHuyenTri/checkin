import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class SalaryTableBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 1000                                                                                                                                                                  
  List<M1000SalaryTableModel> _listSalaryTable1000 = [];                                                                                      
  final _salaryTableSubject1000 = PublishSubject<List<M1000SalaryTableModel>>();                                                        
  Stream<List<M1000SalaryTableModel>> get salaryTableStream1000 => _salaryTableSubject1000.stream;       
																																																
  // for what 1005                                                                                                                                                                
  List<M1000SalaryTableModel> _listSalaryTable1005 = [];                                                                                    
  final _salaryTableSubject1005 = PublishSubject<List<M1000SalaryTableModel>>();                                                      
  Stream<List<M1000SalaryTableModel>> get salaryTableStream1005 => _salaryTableSubject1005.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _salaryTableSubject1000.close();                                                                                                                             
    _salaryTableSubject1005.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1000 get all data SalaryTable                                                                                                                             
   */                                                                                                                                                                                           
  callWhat1000() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 1000;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listSalaryTable1000.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listSalaryTable1000 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _salaryTableSubject1000.sink.add(_listSalaryTable1000);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1005 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat1005(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 1005;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listSalaryTable1005 = [];                                                                                                                               
            _listSalaryTable1005.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listSalaryTable1005.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _salaryTableSubject1005.sink.add(_listSalaryTable1005);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

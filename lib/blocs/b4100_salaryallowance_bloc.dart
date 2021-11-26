import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class SalaryAllowanceBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 4100                                                                                                                                                                  
  List<M4100SalaryAllowanceModel> _listSalaryAllowance4100 = [];                                                                                      
  final _salaryAllowanceSubject4100 = PublishSubject<List<M4100SalaryAllowanceModel>>();                                                        
  Stream<List<M4100SalaryAllowanceModel>> get salaryAllowanceStream4100 => _salaryAllowanceSubject4100.stream;       
																																																
  // for what 4105                                                                                                                                                                
  List<M4100SalaryAllowanceModel> _listSalaryAllowance4105 = [];                                                                                    
  final _salaryAllowanceSubject4105 = PublishSubject<List<M4100SalaryAllowanceModel>>();                                                      
  Stream<List<M4100SalaryAllowanceModel>> get salaryAllowanceStream4105 => _salaryAllowanceSubject4105.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _salaryAllowanceSubject4100.close();                                                                                                                             
    _salaryAllowanceSubject4105.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4100 get all data SalaryAllowance                                                                                                                             
   */                                                                                                                                                                                           
  callWhat4100() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 4100;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listSalaryAllowance4100.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listSalaryAllowance4100 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _salaryAllowanceSubject4100.sink.add(_listSalaryAllowance4100);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4105 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat4105(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 4105;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listSalaryAllowance4105 = [];                                                                                                                               
            _listSalaryAllowance4105.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listSalaryAllowance4105.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _salaryAllowanceSubject4105.sink.add(_listSalaryAllowance4105);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

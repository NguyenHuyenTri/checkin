import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class PayrollBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 4500                                                                                                                                                                  
  List<M4500PayrollModel> _listPayroll4500 = [];                                                                                      
  final _payrollSubject4500 = PublishSubject<List<M4500PayrollModel>>();                                                        
  Stream<List<M4500PayrollModel>> get payrollStream4500 => _payrollSubject4500.stream;       
																																																
  // for what 4505                                                                                                                                                                
  List<M4500PayrollModel> _listPayroll4505 = [];                                                                                    
  final _payrollSubject4505 = PublishSubject<List<M4500PayrollModel>>();                                                      
  Stream<List<M4500PayrollModel>> get payrollStream4505 => _payrollSubject4505.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _payrollSubject4500.close();                                                                                                                             
    _payrollSubject4505.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4500 get all data Payroll                                                                                                                             
   */                                                                                                                                                                                           
  callWhat4500() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 4500;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listPayroll4500.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listPayroll4500 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _payrollSubject4500.sink.add(_listPayroll4500);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4505 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat4505(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 4505;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listPayroll4505 = [];                                                                                                                               
            _listPayroll4505.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listPayroll4505.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _payrollSubject4505.sink.add(_listPayroll4505);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class AllowanceBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 4300                                                                                                                                                                  
  List<M4300AllowanceModel> _listAllowance4300 = [];                                                                                      
  final _allowanceSubject4300 = PublishSubject<List<M4300AllowanceModel>>();                                                        
  Stream<List<M4300AllowanceModel>> get allowanceStream4300 => _allowanceSubject4300.stream;       
																																																
  // for what 4305                                                                                                                                                                
  List<M4300AllowanceModel> _listAllowance4305 = [];                                                                                    
  final _allowanceSubject4305 = PublishSubject<List<M4300AllowanceModel>>();                                                      
  Stream<List<M4300AllowanceModel>> get allowanceStream4305 => _allowanceSubject4305.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _allowanceSubject4300.close();                                                                                                                             
    _allowanceSubject4305.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4300 get all data Allowance                                                                                                                             
   */                                                                                                                                                                                           
  callWhat4300() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 4300;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listAllowance4300.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listAllowance4300 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _allowanceSubject4300.sink.add(_listAllowance4300);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4305 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat4305(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 4305;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listAllowance4305 = [];                                                                                                                               
            _listAllowance4305.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listAllowance4305.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _allowanceSubject4305.sink.add(_listAllowance4305);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

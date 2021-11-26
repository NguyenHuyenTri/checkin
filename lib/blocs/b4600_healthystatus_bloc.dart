import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class HealthyStatusBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 4600                                                                                                                                                                  
  List<M4600HealthyStatusModel> _listHealthyStatus4600 = [];                                                                                      
  final _healthyStatusSubject4600 = PublishSubject<List<M4600HealthyStatusModel>>();                                                        
  Stream<List<M4600HealthyStatusModel>> get healthyStatusStream4600 => _healthyStatusSubject4600.stream;       
																																																
  // for what 4605                                                                                                                                                                
  List<M4600HealthyStatusModel> _listHealthyStatus4605 = [];                                                                                    
  final _healthyStatusSubject4605 = PublishSubject<List<M4600HealthyStatusModel>>();                                                      
  Stream<List<M4600HealthyStatusModel>> get healthyStatusStream4605 => _healthyStatusSubject4605.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _healthyStatusSubject4600.close();                                                                                                                             
    _healthyStatusSubject4605.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4600 get all data HealthyStatus                                                                                                                             
   */                                                                                                                                                                                           
  callWhat4600() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 4600;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listHealthyStatus4600.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listHealthyStatus4600 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _healthyStatusSubject4600.sink.add(_listHealthyStatus4600);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4605 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat4605(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 4605;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listHealthyStatus4605 = [];                                                                                                                               
            _listHealthyStatus4605.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listHealthyStatus4605.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _healthyStatusSubject4605.sink.add(_listHealthyStatus4605);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

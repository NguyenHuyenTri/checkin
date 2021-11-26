import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class ContractBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 3600                                                                                                                                                                  
  List<M3600ContractModel> _listContract3600 = [];                                                                                      
  final _contractSubject3600 = PublishSubject<List<M3600ContractModel>>();                                                        
  Stream<List<M3600ContractModel>> get contractStream3600 => _contractSubject3600.stream;       
																																																
  // for what 3605                                                                                                                                                                
  List<M3600ContractModel> _listContract3605 = [];                                                                                    
  final _contractSubject3605 = PublishSubject<List<M3600ContractModel>>();                                                      
  Stream<List<M3600ContractModel>> get contractStream3605 => _contractSubject3605.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _contractSubject3600.close();                                                                                                                             
    _contractSubject3605.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3600 get all data Contract                                                                                                                             
   */                                                                                                                                                                                           
  callWhat3600() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 3600;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listContract3600.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listContract3600 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _contractSubject3600.sink.add(_listContract3600);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3605 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat3605(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 3605;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listContract3605 = [];                                                                                                                               
            _listContract3605.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listContract3605.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _contractSubject3605.sink.add(_listContract3605);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

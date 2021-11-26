import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class BusinessTypeBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 3300                                                                                                                                                                  
  List<M3300BusinessTypeModel> _listBusinessType3300 = [];                                                                                      
  final _businessTypeSubject3300 = PublishSubject<List<M3300BusinessTypeModel>>();                                                        
  Stream<List<M3300BusinessTypeModel>> get businessTypeStream3300 => _businessTypeSubject3300.stream;       
																																																
  // for what 3305                                                                                                                                                                
  List<M3300BusinessTypeModel> _listBusinessType3305 = [];                                                                                    
  final _businessTypeSubject3305 = PublishSubject<List<M3300BusinessTypeModel>>();                                                      
  Stream<List<M3300BusinessTypeModel>> get businessTypeStream3305 => _businessTypeSubject3305.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _businessTypeSubject3300.close();                                                                                                                             
    _businessTypeSubject3305.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3300 get all data BusinessType                                                                                                                             
   */                                                                                                                                                                                           
  callWhat3300() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 3300;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listBusinessType3300.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listBusinessType3300 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _businessTypeSubject3300.sink.add(_listBusinessType3300);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3305 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat3305(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 3305;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listBusinessType3305 = [];                                                                                                                               
            _listBusinessType3305.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listBusinessType3305.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _businessTypeSubject3305.sink.add(_listBusinessType3305);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

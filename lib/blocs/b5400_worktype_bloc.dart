import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class WorkTypeBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 5400                                                                                                                                                                  
  List<M5400WorkTypeModel> _listWorkType5400 = [];                                                                                      
  final _workTypeSubject5400 = PublishSubject<List<M5400WorkTypeModel>>();                                                        
  Stream<List<M5400WorkTypeModel>> get workTypeStream5400 => _workTypeSubject5400.stream;       
																																																
  // for what 5405                                                                                                                                                                
  List<M5400WorkTypeModel> _listWorkType5405 = [];                                                                                    
  final _workTypeSubject5405 = PublishSubject<List<M5400WorkTypeModel>>();                                                      
  Stream<List<M5400WorkTypeModel>> get workTypeStream5405 => _workTypeSubject5405.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _workTypeSubject5400.close();                                                                                                                             
    _workTypeSubject5405.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5400 get all data WorkType                                                                                                                             
   */                                                                                                                                                                                           
  callWhat5400() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 5400;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listWorkType5400.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listWorkType5400 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _workTypeSubject5400.sink.add(_listWorkType5400);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5405 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat5405(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 5405;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listWorkType5405 = [];                                                                                                                               
            _listWorkType5405.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listWorkType5405.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _workTypeSubject5405.sink.add(_listWorkType5405);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

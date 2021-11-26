import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class FormWorkBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 1200                                                                                                                                                                  
  List<M1200FormWorkModel> _listFormWork1200 = [];                                                                                      
  final _formWorkSubject1200 = PublishSubject<List<M1200FormWorkModel>>();                                                        
  Stream<List<M1200FormWorkModel>> get formWorkStream1200 => _formWorkSubject1200.stream;       
																																																
  // for what 1205                                                                                                                                                                
  List<M1200FormWorkModel> _listFormWork1205 = [];                                                                                    
  final _formWorkSubject1205 = PublishSubject<List<M1200FormWorkModel>>();                                                      
  Stream<List<M1200FormWorkModel>> get formWorkStream1205 => _formWorkSubject1205.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _formWorkSubject1200.close();                                                                                                                             
    _formWorkSubject1205.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1200 get all data FormWork                                                                                                                             
   */                                                                                                                                                                                           
  callWhat1200() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 1200;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listFormWork1200.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listFormWork1200 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _formWorkSubject1200.sink.add(_listFormWork1200);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1205 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat1205(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 1205;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listFormWork1205 = [];                                                                                                                               
            _listFormWork1205.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listFormWork1205.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _formWorkSubject1205.sink.add(_listFormWork1205);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

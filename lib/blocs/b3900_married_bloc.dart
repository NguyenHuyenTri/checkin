import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class MarriedBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 3900                                                                                                                                                                  
  List<M3900MarriedModel> _listMarried3900 = [];                                                                                      
  final _marriedSubject3900 = PublishSubject<List<M3900MarriedModel>>();                                                        
  Stream<List<M3900MarriedModel>> get marriedStream3900 => _marriedSubject3900.stream;       
																																																
  // for what 3905                                                                                                                                                                
  List<M3900MarriedModel> _listMarried3905 = [];                                                                                    
  final _marriedSubject3905 = PublishSubject<List<M3900MarriedModel>>();                                                      
  Stream<List<M3900MarriedModel>> get marriedStream3905 => _marriedSubject3905.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _marriedSubject3900.close();                                                                                                                             
    _marriedSubject3905.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3900 get all data Married                                                                                                                             
   */                                                                                                                                                                                           
  callWhat3900() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 3900;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listMarried3900.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listMarried3900 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _marriedSubject3900.sink.add(_listMarried3900);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3905 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat3905(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 3905;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listMarried3905 = [];                                                                                                                               
            _listMarried3905.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listMarried3905.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _marriedSubject3905.sink.add(_listMarried3905);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

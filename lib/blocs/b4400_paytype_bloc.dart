import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class PayTypeBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 4400                                                                                                                                                                  
  List<M4400PayTypeModel> _listPayType4400 = [];                                                                                      
  final _payTypeSubject4400 = PublishSubject<List<M4400PayTypeModel>>();                                                        
  Stream<List<M4400PayTypeModel>> get payTypeStream4400 => _payTypeSubject4400.stream;       
																																																
  // for what 4405                                                                                                                                                                
  List<M4400PayTypeModel> _listPayType4405 = [];                                                                                    
  final _payTypeSubject4405 = PublishSubject<List<M4400PayTypeModel>>();                                                      
  Stream<List<M4400PayTypeModel>> get payTypeStream4405 => _payTypeSubject4405.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _payTypeSubject4400.close();                                                                                                                             
    _payTypeSubject4405.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4400 get all data PayType                                                                                                                             
   */                                                                                                                                                                                           
  callWhat4400() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 4400;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listPayType4400.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listPayType4400 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _payTypeSubject4400.sink.add(_listPayType4400);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4405 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat4405(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 4405;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listPayType4405 = [];                                                                                                                               
            _listPayType4405.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listPayType4405.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _payTypeSubject4405.sink.add(_listPayType4405);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

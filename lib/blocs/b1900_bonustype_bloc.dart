import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class BonusTypeBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 1900                                                                                                                                                                  
  List<M1900BonusTypeModel> _listBonusType1900 = [];                                                                                      
  final _bonusTypeSubject1900 = PublishSubject<List<M1900BonusTypeModel>>();                                                        
  Stream<List<M1900BonusTypeModel>> get bonusTypeStream1900 => _bonusTypeSubject1900.stream;       
																																																
  // for what 1905                                                                                                                                                                
  List<M1900BonusTypeModel> _listBonusType1905 = [];                                                                                    
  final _bonusTypeSubject1905 = PublishSubject<List<M1900BonusTypeModel>>();                                                      
  Stream<List<M1900BonusTypeModel>> get bonusTypeStream1905 => _bonusTypeSubject1905.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _bonusTypeSubject1900.close();                                                                                                                             
    _bonusTypeSubject1905.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1900 get all data BonusType                                                                                                                             
   */                                                                                                                                                                                           
  callWhat1900() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 1900;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listBonusType1900.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listBonusType1900 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _bonusTypeSubject1900.sink.add(_listBonusType1900);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1905 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat1905(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 1905;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listBonusType1905 = [];                                                                                                                               
            _listBonusType1905.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listBonusType1905.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _bonusTypeSubject1905.sink.add(_listBonusType1905);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

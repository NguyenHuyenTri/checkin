import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class BonusBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 2000                                                                                                                                                                  
  List<M2000BonusModel> _listBonus2000 = [];                                                                                      
  final _bonusSubject2000 = PublishSubject<List<M2000BonusModel>>();                                                        
  Stream<List<M2000BonusModel>> get bonusStream2000 => _bonusSubject2000.stream;       
																																																
  // for what 2005                                                                                                                                                                
  List<M2000BonusModel> _listBonus2005 = [];                                                                                    
  final _bonusSubject2005 = PublishSubject<List<M2000BonusModel>>();                                                      
  Stream<List<M2000BonusModel>> get bonusStream2005 => _bonusSubject2005.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _bonusSubject2000.close();                                                                                                                             
    _bonusSubject2005.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat2000 get all data Bonus                                                                                                                             
   */                                                                                                                                                                                           
  callWhat2000() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 2000;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listBonus2000.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listBonus2000 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _bonusSubject2000.sink.add(_listBonus2000);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat2005 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat2005(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 2005;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listBonus2005 = [];                                                                                                                               
            _listBonus2005.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listBonus2005.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _bonusSubject2005.sink.add(_listBonus2005);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

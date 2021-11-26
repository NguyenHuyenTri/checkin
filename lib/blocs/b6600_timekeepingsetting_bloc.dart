import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class TimeKeepingSettingBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 6600                                                                                                                                                                  
  List<M6600TimeKeepingSettingModel> _listTimeKeepingSetting6600 = [];                                                                                      
  final _timeKeepingSettingSubject6600 = PublishSubject<List<M6600TimeKeepingSettingModel>>();                                                        
  Stream<List<M6600TimeKeepingSettingModel>> get timeKeepingSettingStream6600 => _timeKeepingSettingSubject6600.stream;       
																																																
  // for what 6605                                                                                                                                                                
  List<M6600TimeKeepingSettingModel> _listTimeKeepingSetting6605 = [];                                                                                    
  final _timeKeepingSettingSubject6605 = PublishSubject<List<M6600TimeKeepingSettingModel>>();                                                      
  Stream<List<M6600TimeKeepingSettingModel>> get timeKeepingSettingStream6605 => _timeKeepingSettingSubject6605.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _timeKeepingSettingSubject6600.close();                                                                                                                             
    _timeKeepingSettingSubject6605.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6600 get all data TimeKeepingSetting                                                                                                                             
   */                                                                                                                                                                                           
  callWhat6600() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 6600;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listTimeKeepingSetting6600.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listTimeKeepingSetting6600 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _timeKeepingSettingSubject6600.sink.add(_listTimeKeepingSetting6600);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6605 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat6605(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 6605;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listTimeKeepingSetting6605 = [];                                                                                                                               
            _listTimeKeepingSetting6605.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listTimeKeepingSetting6605.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _timeKeepingSettingSubject6605.sink.add(_listTimeKeepingSetting6605);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

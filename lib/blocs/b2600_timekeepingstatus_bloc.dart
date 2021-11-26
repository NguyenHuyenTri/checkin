import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class TimekeepingStatusBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 2600                                                                                                                                                                  
  List<M2600TimekeepingStatusModel> _listTimekeepingStatus2600 = [];                                                                                      
  final _timekeepingStatusSubject2600 = PublishSubject<List<M2600TimekeepingStatusModel>>();                                                        
  Stream<List<M2600TimekeepingStatusModel>> get timekeepingStatusStream2600 => _timekeepingStatusSubject2600.stream;       
																																																
  // for what 2605                                                                                                                                                                
  List<M2600TimekeepingStatusModel> _listTimekeepingStatus2605 = [];                                                                                    
  final _timekeepingStatusSubject2605 = PublishSubject<List<M2600TimekeepingStatusModel>>();                                                      
  Stream<List<M2600TimekeepingStatusModel>> get timekeepingStatusStream2605 => _timekeepingStatusSubject2605.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _timekeepingStatusSubject2600.close();                                                                                                                             
    _timekeepingStatusSubject2605.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat2600 get all data TimekeepingStatus                                                                                                                             
   */                                                                                                                                                                                           
  callWhat2600() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 2600;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listTimekeepingStatus2600.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listTimekeepingStatus2600 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _timekeepingStatusSubject2600.sink.add(_listTimekeepingStatus2600);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat2605 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat2605(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 2605;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listTimekeepingStatus2605 = [];                                                                                                                               
            _listTimekeepingStatus2605.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listTimekeepingStatus2605.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _timekeepingStatusSubject2605.sink.add(_listTimekeepingStatus2605);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

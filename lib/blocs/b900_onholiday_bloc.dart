import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class OnHolidayBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 900                                                                                                                                                                  
  List<M900OnHolidayModel> _listOnHoliday900 = [];                                                                                      
  final _onHolidaySubject900 = PublishSubject<List<M900OnHolidayModel>>();                                                        
  Stream<List<M900OnHolidayModel>> get onHolidayStream900 => _onHolidaySubject900.stream;       
																																																
  // for what 905                                                                                                                                                                
  List<M900OnHolidayModel> _listOnHoliday905 = [];                                                                                    
  final _onHolidaySubject905 = PublishSubject<List<M900OnHolidayModel>>();                                                      
  Stream<List<M900OnHolidayModel>> get onHolidayStream905 => _onHolidaySubject905.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _onHolidaySubject900.close();                                                                                                                             
    _onHolidaySubject905.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat900 get all data OnHoliday                                                                                                                             
   */                                                                                                                                                                                           
  callWhat900() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 900;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listOnHoliday900.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listOnHoliday900 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _onHolidaySubject900.sink.add(_listOnHoliday900);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat905 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat905(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 905;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listOnHoliday905 = [];                                                                                                                               
            _listOnHoliday905.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listOnHoliday905.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _onHolidaySubject905.sink.add(_listOnHoliday905);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

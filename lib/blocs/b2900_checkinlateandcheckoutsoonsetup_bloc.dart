import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class CheckinLateAndCheckoutSoonSetupBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 2900                                                                                                                                                                  
  List<M2900CheckinLateAndCheckoutSoonSetupModel> _listCheckinLateAndCheckoutSoonSetup2900 = [];                                                                                      
  final _checkinLateAndCheckoutSoonSetupSubject2900 = PublishSubject<List<M2900CheckinLateAndCheckoutSoonSetupModel>>();                                                        
  Stream<List<M2900CheckinLateAndCheckoutSoonSetupModel>> get checkinLateAndCheckoutSoonSetupStream2900 => _checkinLateAndCheckoutSoonSetupSubject2900.stream;       
																																																
  // for what 2905                                                                                                                                                                
  List<M2900CheckinLateAndCheckoutSoonSetupModel> _listCheckinLateAndCheckoutSoonSetup2905 = [];                                                                                    
  final _checkinLateAndCheckoutSoonSetupSubject2905 = PublishSubject<List<M2900CheckinLateAndCheckoutSoonSetupModel>>();                                                      
  Stream<List<M2900CheckinLateAndCheckoutSoonSetupModel>> get checkinLateAndCheckoutSoonSetupStream2905 => _checkinLateAndCheckoutSoonSetupSubject2905.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _checkinLateAndCheckoutSoonSetupSubject2900.close();                                                                                                                             
    _checkinLateAndCheckoutSoonSetupSubject2905.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat2900 get all data CheckinLateAndCheckoutSoonSetup                                                                                                                             
   */                                                                                                                                                                                           
  callWhat2900() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 2900;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listCheckinLateAndCheckoutSoonSetup2900.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listCheckinLateAndCheckoutSoonSetup2900 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _checkinLateAndCheckoutSoonSetupSubject2900.sink.add(_listCheckinLateAndCheckoutSoonSetup2900);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat2905 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat2905(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 2905;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listCheckinLateAndCheckoutSoonSetup2905 = [];                                                                                                                               
            _listCheckinLateAndCheckoutSoonSetup2905.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listCheckinLateAndCheckoutSoonSetup2905.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _checkinLateAndCheckoutSoonSetupSubject2905.sink.add(_listCheckinLateAndCheckoutSoonSetup2905);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

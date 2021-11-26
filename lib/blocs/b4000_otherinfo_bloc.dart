import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class OtherInfoBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 4000                                                                                                                                                                  
  List<M4000OtherInfoModel> _listOtherInfo4000 = [];                                                                                      
  final _otherInfoSubject4000 = PublishSubject<List<M4000OtherInfoModel>>();                                                        
  Stream<List<M4000OtherInfoModel>> get otherInfoStream4000 => _otherInfoSubject4000.stream;       
																																																
  // for what 4005                                                                                                                                                                
  List<M4000OtherInfoModel> _listOtherInfo4005 = [];                                                                                    
  final _otherInfoSubject4005 = PublishSubject<List<M4000OtherInfoModel>>();                                                      
  Stream<List<M4000OtherInfoModel>> get otherInfoStream4005 => _otherInfoSubject4005.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _otherInfoSubject4000.close();                                                                                                                             
    _otherInfoSubject4005.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4000 get all data OtherInfo                                                                                                                             
   */                                                                                                                                                                                           
  callWhat4000() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 4000;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listOtherInfo4000.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listOtherInfo4000 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _otherInfoSubject4000.sink.add(_listOtherInfo4000);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4005 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat4005(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 4005;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listOtherInfo4005 = [];                                                                                                                               
            _listOtherInfo4005.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listOtherInfo4005.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _otherInfoSubject4005.sink.add(_listOtherInfo4005);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

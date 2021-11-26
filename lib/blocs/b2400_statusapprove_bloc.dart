import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class StatusApproveBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 2400                                                                                                                                                                  
  List<M2400StatusApproveModel> _listStatusApprove2400 = [];                                                                                      
  final _statusApproveSubject2400 = PublishSubject<List<M2400StatusApproveModel>>();                                                        
  Stream<List<M2400StatusApproveModel>> get statusApproveStream2400 => _statusApproveSubject2400.stream;       
																																																
  // for what 2405                                                                                                                                                                
  List<M2400StatusApproveModel> _listStatusApprove2405 = [];                                                                                    
  final _statusApproveSubject2405 = PublishSubject<List<M2400StatusApproveModel>>();                                                      
  Stream<List<M2400StatusApproveModel>> get statusApproveStream2405 => _statusApproveSubject2405.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _statusApproveSubject2400.close();                                                                                                                             
    _statusApproveSubject2405.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat2400 get all data StatusApprove                                                                                                                             
   */                                                                                                                                                                                           
  callWhat2400() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 2400;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listStatusApprove2400.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listStatusApprove2400 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _statusApproveSubject2400.sink.add(_listStatusApprove2400);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat2405 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat2405(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 2405;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listStatusApprove2405 = [];                                                                                                                               
            _listStatusApprove2405.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listStatusApprove2405.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _statusApproveSubject2405.sink.add(_listStatusApprove2405);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

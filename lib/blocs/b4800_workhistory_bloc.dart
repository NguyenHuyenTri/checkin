import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class WorkHistoryBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 4800                                                                                                                                                                  
  List<M4800WorkHistoryModel> _listWorkHistory4800 = [];                                                                                      
  final _workHistorySubject4800 = PublishSubject<List<M4800WorkHistoryModel>>();                                                        
  Stream<List<M4800WorkHistoryModel>> get workHistoryStream4800 => _workHistorySubject4800.stream;       
																																																
  // for what 4805                                                                                                                                                                
  List<M4800WorkHistoryModel> _listWorkHistory4805 = [];                                                                                    
  final _workHistorySubject4805 = PublishSubject<List<M4800WorkHistoryModel>>();                                                      
  Stream<List<M4800WorkHistoryModel>> get workHistoryStream4805 => _workHistorySubject4805.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _workHistorySubject4800.close();                                                                                                                             
    _workHistorySubject4805.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4800 get all data WorkHistory                                                                                                                             
   */                                                                                                                                                                                           
  callWhat4800() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 4800;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listWorkHistory4800.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listWorkHistory4800 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _workHistorySubject4800.sink.add(_listWorkHistory4800);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4805 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat4805(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 4805;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listWorkHistory4805 = [];                                                                                                                               
            _listWorkHistory4805.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listWorkHistory4805.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _workHistorySubject4805.sink.add(_listWorkHistory4805);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

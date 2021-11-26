import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class WorkingTimeBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 5200                                                                                                                                                                  
  List<M5200WorkingTimeModel> _listWorkingTime5200 = [];                                                                                      
  final _workingTimeSubject5200 = PublishSubject<List<M5200WorkingTimeModel>>();                                                        
  Stream<List<M5200WorkingTimeModel>> get workingTimeStream5200 => _workingTimeSubject5200.stream;       
																																																
  // for what 5205                                                                                                                                                                
  List<M5200WorkingTimeModel> _listWorkingTime5205 = [];                                                                                    
  final _workingTimeSubject5205 = PublishSubject<List<M5200WorkingTimeModel>>();                                                      
  Stream<List<M5200WorkingTimeModel>> get workingTimeStream5205 => _workingTimeSubject5205.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _workingTimeSubject5200.close();                                                                                                                             
    _workingTimeSubject5205.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5200 get all data WorkingTime                                                                                                                             
   */                                                                                                                                                                                           
  callWhat5200() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 5200;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listWorkingTime5200.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listWorkingTime5200 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _workingTimeSubject5200.sink.add(_listWorkingTime5200);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5205 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat5205(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 5205;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listWorkingTime5205 = [];                                                                                                                               
            _listWorkingTime5205.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listWorkingTime5205.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _workingTimeSubject5205.sink.add(_listWorkingTime5205);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

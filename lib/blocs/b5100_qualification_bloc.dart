import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class QualificationBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 5100                                                                                                                                                                  
  List<M5100QualificationModel> _listQualification5100 = [];                                                                                      
  final _qualificationSubject5100 = PublishSubject<List<M5100QualificationModel>>();                                                        
  Stream<List<M5100QualificationModel>> get qualificationStream5100 => _qualificationSubject5100.stream;       
																																																
  // for what 5105                                                                                                                                                                
  List<M5100QualificationModel> _listQualification5105 = [];                                                                                    
  final _qualificationSubject5105 = PublishSubject<List<M5100QualificationModel>>();                                                      
  Stream<List<M5100QualificationModel>> get qualificationStream5105 => _qualificationSubject5105.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _qualificationSubject5100.close();                                                                                                                             
    _qualificationSubject5105.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5100 get all data Qualification                                                                                                                             
   */                                                                                                                                                                                           
  callWhat5100() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 5100;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listQualification5100.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listQualification5100 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _qualificationSubject5100.sink.add(_listQualification5100);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5105 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat5105(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 5105;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listQualification5105 = [];                                                                                                                               
            _listQualification5105.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listQualification5105.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _qualificationSubject5105.sink.add(_listQualification5105);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

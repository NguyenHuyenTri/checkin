import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class AcademicLevelBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 6000                                                                                                                                                                  
  List<M6000AcademicLevelModel> _listAcademicLevel6000 = [];                                                                                      
  final _academicLevelSubject6000 = PublishSubject<List<M6000AcademicLevelModel>>();                                                        
  Stream<List<M6000AcademicLevelModel>> get academicLevelStream6000 => _academicLevelSubject6000.stream;       
																																																
  // for what 6005                                                                                                                                                                
  List<M6000AcademicLevelModel> _listAcademicLevel6005 = [];                                                                                    
  final _academicLevelSubject6005 = PublishSubject<List<M6000AcademicLevelModel>>();                                                      
  Stream<List<M6000AcademicLevelModel>> get academicLevelStream6005 => _academicLevelSubject6005.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _academicLevelSubject6000.close();                                                                                                                             
    _academicLevelSubject6005.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6000 get all data AcademicLevel                                                                                                                             
   */                                                                                                                                                                                           
  callWhat6000() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 6000;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listAcademicLevel6000.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listAcademicLevel6000 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _academicLevelSubject6000.sink.add(_listAcademicLevel6000);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6005 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat6005(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 6005;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listAcademicLevel6005 = [];                                                                                                                               
            _listAcademicLevel6005.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listAcademicLevel6005.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _academicLevelSubject6005.sink.add(_listAcademicLevel6005);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

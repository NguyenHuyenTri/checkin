import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class AdvancedTimekeepingSetupBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 3100                                                                                                                                                                  
  List<M3100AdvancedTimekeepingSetupModel> _listAdvancedTimekeepingSetup3100 = [];                                                                                      
  final _advancedTimekeepingSetupSubject3100 = PublishSubject<List<M3100AdvancedTimekeepingSetupModel>>();                                                        
  Stream<List<M3100AdvancedTimekeepingSetupModel>> get advancedTimekeepingSetupStream3100 => _advancedTimekeepingSetupSubject3100.stream;       
																																																
  // for what 3105                                                                                                                                                                
  List<M3100AdvancedTimekeepingSetupModel> _listAdvancedTimekeepingSetup3105 = [];                                                                                    
  final _advancedTimekeepingSetupSubject3105 = PublishSubject<List<M3100AdvancedTimekeepingSetupModel>>();                                                      
  Stream<List<M3100AdvancedTimekeepingSetupModel>> get advancedTimekeepingSetupStream3105 => _advancedTimekeepingSetupSubject3105.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _advancedTimekeepingSetupSubject3100.close();                                                                                                                             
    _advancedTimekeepingSetupSubject3105.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3100 get all data AdvancedTimekeepingSetup                                                                                                                             
   */                                                                                                                                                                                           
  callWhat3100() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 3100;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listAdvancedTimekeepingSetup3100.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listAdvancedTimekeepingSetup3100 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _advancedTimekeepingSetupSubject3100.sink.add(_listAdvancedTimekeepingSetup3100);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3105 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat3105(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 3105;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listAdvancedTimekeepingSetup3105 = [];                                                                                                                               
            _listAdvancedTimekeepingSetup3105.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listAdvancedTimekeepingSetup3105.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _advancedTimekeepingSetupSubject3105.sink.add(_listAdvancedTimekeepingSetup3105);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

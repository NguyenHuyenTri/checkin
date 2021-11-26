import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class ViewRuleBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 6700                                                                                                                                                                  
  List<M6700ViewRuleModel> _listViewRule6700 = [];                                                                                      
  final _viewRuleSubject6700 = PublishSubject<List<M6700ViewRuleModel>>();                                                        
  Stream<List<M6700ViewRuleModel>> get viewRuleStream6700 => _viewRuleSubject6700.stream;       
																																																
  // for what 6705                                                                                                                                                                
  List<M6700ViewRuleModel> _listViewRule6705 = [];                                                                                    
  final _viewRuleSubject6705 = PublishSubject<List<M6700ViewRuleModel>>();                                                      
  Stream<List<M6700ViewRuleModel>> get viewRuleStream6705 => _viewRuleSubject6705.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _viewRuleSubject6700.close();                                                                                                                             
    _viewRuleSubject6705.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6700 get all data ViewRule                                                                                                                             
   */                                                                                                                                                                                           
  callWhat6700() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 6700;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listViewRule6700.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listViewRule6700 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _viewRuleSubject6700.sink.add(_listViewRule6700);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6705 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat6705(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 6705;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listViewRule6705 = [];                                                                                                                               
            _listViewRule6705.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listViewRule6705.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _viewRuleSubject6705.sink.add(_listViewRule6705);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

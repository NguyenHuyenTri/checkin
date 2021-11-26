import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class RuleBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 500                                                                                                                                                                  
  List listRule500 = [];
  final ruleSubject500 = PublishSubject();
  Stream get ruleStream500 => ruleSubject500.stream;
																																																
  // for what 505                                                                                                                                                                
  List<M500RuleModel> _listRule505 = [];                                                                                    
  final _ruleSubject505 = PublishSubject<List<M500RuleModel>>();                                                      
  Stream<List<M500RuleModel>> get ruleStream505 => _ruleSubject505.stream;


  List listRule507 = [];
  final ruleSubject507 = PublishSubject();
  Stream get ruleStream507 => ruleSubject507.stream;
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    ruleSubject500.close();
    _ruleSubject505.close();
    ruleSubject507.close();
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat500 get all data Rule                                                                                                                             
   */                                                                                                                                                                                           
  callWhat500() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 500;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {
          print(value.toString()+'bloc 500');
          listRule500 =value;
        }else{                                                                                                                                                                                  
          listRule500 = [];
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        ruleSubject500.sink.add(listRule500);
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat505 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat505(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 505;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listRule505 = [];                                                                                                                               
            _listRule505.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listRule505.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _ruleSubject505.sink.add(_listRule505);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }
  callWhat507(Map<String ,dynamic> param) async {
    try {
      var what = 507;
      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          print(value.toString()+'bloc 507');
          listRule507 =value;
        }else{
          listRule507 = [];
        }
      }).whenComplete(() {
        ruleSubject507.sink.add(listRule507);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}                                                                                                                                                                                               

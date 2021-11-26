import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class RoleEmployeeBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 5700                                                                                                                                                                  
  List<M5700RoleEmployeeModel> _listRoleEmployee5700 = [];                                                                                      
  final _roleEmployeeSubject5700 = PublishSubject<List<M5700RoleEmployeeModel>>();                                                        
  Stream<List<M5700RoleEmployeeModel>> get roleEmployeeStream5700 => _roleEmployeeSubject5700.stream;       
																																																
  // for what 5705                                                                                                                                                                
  List<M5700RoleEmployeeModel> _listRoleEmployee5705 = [];                                                                                    
  final _roleEmployeeSubject5705 = PublishSubject<List<M5700RoleEmployeeModel>>();                                                      
  Stream<List<M5700RoleEmployeeModel>> get roleEmployeeStream5705 => _roleEmployeeSubject5705.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _roleEmployeeSubject5700.close();                                                                                                                             
    _roleEmployeeSubject5705.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5700 get all data RoleEmployee                                                                                                                             
   */                                                                                                                                                                                           
  callWhat5700() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 5700;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listRoleEmployee5700.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listRoleEmployee5700 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _roleEmployeeSubject5700.sink.add(_listRoleEmployee5700);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5705 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat5705(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 5705;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listRoleEmployee5705 = [];                                                                                                                               
            _listRoleEmployee5705.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listRoleEmployee5705.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _roleEmployeeSubject5705.sink.add(_listRoleEmployee5705);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

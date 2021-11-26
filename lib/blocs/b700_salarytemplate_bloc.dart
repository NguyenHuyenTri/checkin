import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class SalaryTemplateBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 700                                                                                                                                                                  
  List<M700SalaryTemplateModel> _listSalaryTemplate700 = [];                                                                                      
  final _salaryTemplateSubject700 = PublishSubject<List<M700SalaryTemplateModel>>();                                                        
  Stream<List<M700SalaryTemplateModel>> get salaryTemplateStream700 => _salaryTemplateSubject700.stream;       
																																																
  // for what 705                                                                                                                                                                
  List<M700SalaryTemplateModel> _listSalaryTemplate705 = [];                                                                                    
  final _salaryTemplateSubject705 = PublishSubject<List<M700SalaryTemplateModel>>();                                                      
  Stream<List<M700SalaryTemplateModel>> get salaryTemplateStream705 => _salaryTemplateSubject705.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _salaryTemplateSubject700.close();                                                                                                                             
    _salaryTemplateSubject705.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat700 get all data SalaryTemplate                                                                                                                             
   */                                                                                                                                                                                           
  callWhat700() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 700;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listSalaryTemplate700.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listSalaryTemplate700 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _salaryTemplateSubject700.sink.add(_listSalaryTemplate700);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat705 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat705(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 705;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listSalaryTemplate705 = [];                                                                                                                               
            _listSalaryTemplate705.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listSalaryTemplate705.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _salaryTemplateSubject705.sink.add(_listSalaryTemplate705);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

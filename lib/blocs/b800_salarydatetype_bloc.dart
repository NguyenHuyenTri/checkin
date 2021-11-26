import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class SalaryDateTypeBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 800                                                                                                                                                                  
  List<M800SalaryDateTypeModel> _listSalaryDateType800 = [];                                                                                      
  final _salaryDateTypeSubject800 = PublishSubject<List<M800SalaryDateTypeModel>>();                                                        
  Stream<List<M800SalaryDateTypeModel>> get salaryDateTypeStream800 => _salaryDateTypeSubject800.stream;       
																																																
  // for what 805                                                                                                                                                                
  List<M800SalaryDateTypeModel> _listSalaryDateType805 = [];                                                                                    
  final _salaryDateTypeSubject805 = PublishSubject<List<M800SalaryDateTypeModel>>();                                                      
  Stream<List<M800SalaryDateTypeModel>> get salaryDateTypeStream805 => _salaryDateTypeSubject805.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _salaryDateTypeSubject800.close();                                                                                                                             
    _salaryDateTypeSubject805.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat800 get all data SalaryDateType                                                                                                                             
   */                                                                                                                                                                                           
  callWhat800() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 800;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listSalaryDateType800.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listSalaryDateType800 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _salaryDateTypeSubject800.sink.add(_listSalaryDateType800);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat805 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat805(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 805;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listSalaryDateType805 = [];                                                                                                                               
            _listSalaryDateType805.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listSalaryDateType805.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _salaryDateTypeSubject805.sink.add(_listSalaryDateType805);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

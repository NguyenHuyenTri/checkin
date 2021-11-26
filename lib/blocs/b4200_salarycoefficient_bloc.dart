import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class SalaryCoefficientBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 4200                                                                                                                                                                  
  List<M4200SalaryCoefficientModel> _listSalaryCoefficient4200 = [];                                                                                      
  final _salaryCoefficientSubject4200 = PublishSubject<List<M4200SalaryCoefficientModel>>();                                                        
  Stream<List<M4200SalaryCoefficientModel>> get salaryCoefficientStream4200 => _salaryCoefficientSubject4200.stream;       
																																																
  // for what 4205                                                                                                                                                                
  List<M4200SalaryCoefficientModel> _listSalaryCoefficient4205 = [];                                                                                    
  final _salaryCoefficientSubject4205 = PublishSubject<List<M4200SalaryCoefficientModel>>();                                                      
  Stream<List<M4200SalaryCoefficientModel>> get salaryCoefficientStream4205 => _salaryCoefficientSubject4205.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _salaryCoefficientSubject4200.close();                                                                                                                             
    _salaryCoefficientSubject4205.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4200 get all data SalaryCoefficient                                                                                                                             
   */                                                                                                                                                                                           
  callWhat4200() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 4200;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listSalaryCoefficient4200.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listSalaryCoefficient4200 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _salaryCoefficientSubject4200.sink.add(_listSalaryCoefficient4200);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4205 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat4205(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 4205;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listSalaryCoefficient4205 = [];                                                                                                                               
            _listSalaryCoefficient4205.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listSalaryCoefficient4205.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _salaryCoefficientSubject4205.sink.add(_listSalaryCoefficient4205);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

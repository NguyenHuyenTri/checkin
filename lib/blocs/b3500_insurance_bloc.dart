import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class InsuranceBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 3500                                                                                                                                                                  
  List<M3500InsuranceModel> _listInsurance3500 = [];                                                                                      
  final _insuranceSubject3500 = PublishSubject<List<M3500InsuranceModel>>();                                                        
  Stream<List<M3500InsuranceModel>> get insuranceStream3500 => _insuranceSubject3500.stream;       
																																																
  // for what 3505                                                                                                                                                                
  List<M3500InsuranceModel> _listInsurance3505 = [];                                                                                    
  final _insuranceSubject3505 = PublishSubject<List<M3500InsuranceModel>>();                                                      
  Stream<List<M3500InsuranceModel>> get insuranceStream3505 => _insuranceSubject3505.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _insuranceSubject3500.close();                                                                                                                             
    _insuranceSubject3505.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3500 get all data Insurance                                                                                                                             
   */                                                                                                                                                                                           
  callWhat3500() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 3500;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listInsurance3500.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listInsurance3500 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _insuranceSubject3500.sink.add(_listInsurance3500);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3505 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat3505(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 3505;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listInsurance3505 = [];                                                                                                                               
            _listInsurance3505.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listInsurance3505.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _insuranceSubject3505.sink.add(_listInsurance3505);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

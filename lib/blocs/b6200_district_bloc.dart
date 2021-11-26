import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class DistrictBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 6200                                                                                                                                                                  
  List<M6200DistrictModel> _listDistrict6200 = [];                                                                                      
  final _districtSubject6200 = PublishSubject<List<M6200DistrictModel>>();                                                        
  Stream<List<M6200DistrictModel>> get districtStream6200 => _districtSubject6200.stream;       
																																																
  // for what 6205                                                                                                                                                                
  List<M6200DistrictModel> _listDistrict6205 = [];                                                                                    
  final _districtSubject6205 = PublishSubject<List<M6200DistrictModel>>();                                                      
  Stream<List<M6200DistrictModel>> get districtStream6205 => _districtSubject6205.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _districtSubject6200.close();                                                                                                                             
    _districtSubject6205.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6200 get all data District                                                                                                                             
   */                                                                                                                                                                                           
  callWhat6200() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 6200;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listDistrict6200.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listDistrict6200 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _districtSubject6200.sink.add(_listDistrict6200);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6205 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat6205(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 6205;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listDistrict6205 = [];                                                                                                                               
            _listDistrict6205.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listDistrict6205.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _districtSubject6205.sink.add(_listDistrict6205);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

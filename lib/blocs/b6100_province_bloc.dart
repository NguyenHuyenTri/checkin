import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class ProvinceBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 6100                                                                                                                                                                  
  List<M6100ProvinceModel> _listProvince6100 = [];                                                                                      
  final _provinceSubject6100 = PublishSubject<List<M6100ProvinceModel>>();                                                        
  Stream<List<M6100ProvinceModel>> get provinceStream6100 => _provinceSubject6100.stream;       
																																																
  // for what 6105                                                                                                                                                                
  List<M6100ProvinceModel> _listProvince6105 = [];                                                                                    
  final _provinceSubject6105 = PublishSubject<List<M6100ProvinceModel>>();                                                      
  Stream<List<M6100ProvinceModel>> get provinceStream6105 => _provinceSubject6105.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _provinceSubject6100.close();                                                                                                                             
    _provinceSubject6105.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6100 get all data Province                                                                                                                             
   */                                                                                                                                                                                           
  callWhat6100() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 6100;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listProvince6100.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listProvince6100 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _provinceSubject6100.sink.add(_listProvince6100);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6105 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat6105(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 6105;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listProvince6105 = [];                                                                                                                               
            _listProvince6105.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listProvince6105.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _provinceSubject6105.sink.add(_listProvince6105);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class ContactInfoBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 4700                                                                                                                                                                  
  List<M4700ContactInfoModel> _listContactInfo4700 = [];                                                                                      
  final _contactInfoSubject4700 = PublishSubject<List<M4700ContactInfoModel>>();                                                        
  Stream<List<M4700ContactInfoModel>> get contactInfoStream4700 => _contactInfoSubject4700.stream;       
																																																
  // for what 4705                                                                                                                                                                
  List<M4700ContactInfoModel> _listContactInfo4705 = [];                                                                                    
  final _contactInfoSubject4705 = PublishSubject<List<M4700ContactInfoModel>>();                                                      
  Stream<List<M4700ContactInfoModel>> get contactInfoStream4705 => _contactInfoSubject4705.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _contactInfoSubject4700.close();                                                                                                                             
    _contactInfoSubject4705.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4700 get all data ContactInfo                                                                                                                             
   */                                                                                                                                                                                           
  callWhat4700() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 4700;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listContactInfo4700.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listContactInfo4700 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _contactInfoSubject4700.sink.add(_listContactInfo4700);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4705 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat4705(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 4705;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listContactInfo4705 = [];                                                                                                                               
            _listContactInfo4705.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listContactInfo4705.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _contactInfoSubject4705.sink.add(_listContactInfo4705);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

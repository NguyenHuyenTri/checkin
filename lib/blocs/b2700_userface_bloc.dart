import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class UserFaceBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 2700                                                                                                                                                                  
  List<M2700UserFaceModel> _listUserFace2700 = [];                                                                                      
  final _userFaceSubject2700 = PublishSubject<List<M2700UserFaceModel>>();                                                        
  Stream<List<M2700UserFaceModel>> get userFaceStream2700 => _userFaceSubject2700.stream;       
																																																
  // for what 2705                                                                                                                                                                
  List<M2700UserFaceModel> _listUserFace2705 = [];                                                                                    
  final _userFaceSubject2705 = PublishSubject<List<M2700UserFaceModel>>();                                                      
  Stream<List<M2700UserFaceModel>> get userFaceStream2705 => _userFaceSubject2705.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _userFaceSubject2700.close();                                                                                                                             
    _userFaceSubject2705.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat2700 get all data UserFace                                                                                                                             
   */                                                                                                                                                                                           
  callWhat2700() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 2700;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listUserFace2700.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listUserFace2700 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _userFaceSubject2700.sink.add(_listUserFace2700);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat2705 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat2705(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 2705;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listUserFace2705 = [];                                                                                                                               
            _listUserFace2705.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listUserFace2705.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _userFaceSubject2705.sink.add(_listUserFace2705);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

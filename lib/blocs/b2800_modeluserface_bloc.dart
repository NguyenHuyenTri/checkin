import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class ModelUserFaceBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 2800                                                                                                                                                                  
  List<M2800ModelUserFaceModel> _listModelUserFace2800 = [];                                                                                      
  final _modelUserFaceSubject2800 = PublishSubject<List<M2800ModelUserFaceModel>>();                                                        
  Stream<List<M2800ModelUserFaceModel>> get modelUserFaceStream2800 => _modelUserFaceSubject2800.stream;       
																																																
  // for what 2805                                                                                                                                                                
  List<M2800ModelUserFaceModel> _listModelUserFace2805 = [];                                                                                    
  final _modelUserFaceSubject2805 = PublishSubject<List<M2800ModelUserFaceModel>>();                                                      
  Stream<List<M2800ModelUserFaceModel>> get modelUserFaceStream2805 => _modelUserFaceSubject2805.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _modelUserFaceSubject2800.close();                                                                                                                             
    _modelUserFaceSubject2805.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat2800 get all data ModelUserFace                                                                                                                             
   */                                                                                                                                                                                           
  callWhat2800() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 2800;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listModelUserFace2800.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listModelUserFace2800 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _modelUserFaceSubject2800.sink.add(_listModelUserFace2800);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat2805 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat2805(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 2805;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listModelUserFace2805 = [];                                                                                                                               
            _listModelUserFace2805.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listModelUserFace2805.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _modelUserFaceSubject2805.sink.add(_listModelUserFace2805);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

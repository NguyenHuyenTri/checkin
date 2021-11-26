import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class MajorBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 5300                                                                                                                                                                  
  List<M5300MajorModel> _listMajor5300 = [];                                                                                      
  final _majorSubject5300 = PublishSubject<List<M5300MajorModel>>();                                                        
  Stream<List<M5300MajorModel>> get majorStream5300 => _majorSubject5300.stream;       
																																																
  // for what 5305                                                                                                                                                                
  List<M5300MajorModel> _listMajor5305 = [];                                                                                    
  final _majorSubject5305 = PublishSubject<List<M5300MajorModel>>();                                                      
  Stream<List<M5300MajorModel>> get majorStream5305 => _majorSubject5305.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _majorSubject5300.close();                                                                                                                             
    _majorSubject5305.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5300 get all data Major                                                                                                                             
   */                                                                                                                                                                                           
  callWhat5300() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 5300;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listMajor5300.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listMajor5300 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _majorSubject5300.sink.add(_listMajor5300);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5305 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat5305(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 5305;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listMajor5305 = [];                                                                                                                               
            _listMajor5305.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listMajor5305.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _majorSubject5305.sink.add(_listMajor5305);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

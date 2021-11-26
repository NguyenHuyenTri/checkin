import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class AnnouncementTypeBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 6400                                                                                                                                                                  
  List<M6400AnnouncementTypeModel> _listAnnouncementType6400 = [];                                                                                      
  final _announcementTypeSubject6400 = PublishSubject<List<M6400AnnouncementTypeModel>>();                                                        
  Stream<List<M6400AnnouncementTypeModel>> get announcementTypeStream6400 => _announcementTypeSubject6400.stream;       
																																																
  // for what 6405                                                                                                                                                                
  List<M6400AnnouncementTypeModel> _listAnnouncementType6405 = [];                                                                                    
  final _announcementTypeSubject6405 = PublishSubject<List<M6400AnnouncementTypeModel>>();                                                      
  Stream<List<M6400AnnouncementTypeModel>> get announcementTypeStream6405 => _announcementTypeSubject6405.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _announcementTypeSubject6400.close();                                                                                                                             
    _announcementTypeSubject6405.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6400 get all data AnnouncementType                                                                                                                             
   */                                                                                                                                                                                           
  callWhat6400() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 6400;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listAnnouncementType6400.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listAnnouncementType6400 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _announcementTypeSubject6400.sink.add(_listAnnouncementType6400);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6405 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat6405(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 6405;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listAnnouncementType6405 = [];                                                                                                                               
            _listAnnouncementType6405.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listAnnouncementType6405.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _announcementTypeSubject6405.sink.add(_listAnnouncementType6405);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

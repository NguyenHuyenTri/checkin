import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class AnnouncementBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 600                                                                                                                                                                  
  List<M600AnnouncementModel> _listAnnouncement600 = [];                                                                                      
  final _announcementSubject600 = PublishSubject<List<M600AnnouncementModel>>();                                                        
  Stream<List<M600AnnouncementModel>> get announcementStream600 => _announcementSubject600.stream;       
																																																
  // for what 605                                                                                                                                                                
  List<M600AnnouncementModel> _listAnnouncement605 = [];                                                                                    
  final _announcementSubject605 = PublishSubject<List<M600AnnouncementModel>>();                                                      
  Stream<List<M600AnnouncementModel>> get announcementStream605 => _announcementSubject605.stream;

  // for what 607
  List listAnnouncement607 = [];
  final _announcementSubject607 = PublishSubject();
  Stream get announcementStream607 => _announcementSubject607.stream;

  // for what 608
  var listAnnouncement608;
  final _announcementSubject608 = PublishSubject();
  Stream get announcementStream608 => _announcementSubject608.stream;

  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _announcementSubject600.close();                                                                                                                             
    _announcementSubject605.close();
    _announcementSubject607.close();
    _announcementSubject608.close();
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat600 get all data Announcement                                                                                                                             
   */                                                                                                                                                                                           
  callWhat600() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 600;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listAnnouncement600.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listAnnouncement600 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _announcementSubject600.sink.add(_listAnnouncement600);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat605 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat605(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 605;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listAnnouncement605 = [];                                                                                                                               
            _listAnnouncement605.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listAnnouncement605.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _announcementSubject605.sink.add(_listAnnouncement605);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }
  callWhat607(Map<String,dynamic> param) async {
    try {
      var what = 607;
      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          listAnnouncement607=value;
        }else{
          listAnnouncement607= [];
        }
      }).whenComplete(() {
        _announcementSubject607.sink.add(listAnnouncement607);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  callWhat608(Map<String,dynamic> param) async {
    try {
      var what = 608;
      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          listAnnouncement608=value;
        }else{
          listAnnouncement608= [];
        }
      }).whenComplete(() {
        _announcementSubject608.sink.add(listAnnouncement608);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}                                                                                                                                                                                               

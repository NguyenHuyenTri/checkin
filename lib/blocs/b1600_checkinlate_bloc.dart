import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class CheckinLateBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 1600                                                                                                                                                                  
  List<M1600CheckinLateModel> _listCheckinLate1600 = [];                                                                                      
  final _checkinLateSubject1600 = PublishSubject<List<M1600CheckinLateModel>>();                                                        
  Stream<List<M1600CheckinLateModel>> get checkinLateStream1600 => _checkinLateSubject1600.stream;

  // for what 1601
  List<M1600CheckinLateModel> listCheckinLate1601 = [];
  final _checkinLateSubject1601 = PublishSubject<List<M1600CheckinLateModel>>();
  Stream<List<M1600CheckinLateModel>> get checkinLateStream2509 => _checkinLateSubject1601.stream;

  // for what 1605                                                                                                                                                                
  List<M1600CheckinLateModel> _listCheckinLate1605 = [];                                                                                    
  final _checkinLateSubject1605 = PublishSubject<List<M1600CheckinLateModel>>();                                                      
  Stream<List<M1600CheckinLateModel>> get checkinLateStream1605 => _checkinLateSubject1605.stream;

  // for what 1613
  var listCheckinLate1613 = [];
  final _checkinLateSubject1613 = PublishSubject();
  Stream get checkinLateStream1613 => _checkinLateSubject1613.stream;

  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _checkinLateSubject1600.close();                                                                                                                             
    _checkinLateSubject1605.close();
    _checkinLateSubject1613.close();
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1600 get all data CheckinLate                                                                                                                             
   */                                                                                                                                                                                           
  callWhat1600() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 1600;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listCheckinLate1600.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listCheckinLate1600 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _checkinLateSubject1600.sink.add(_listCheckinLate1600);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }

  /**
   * callWhat1601 insert data CheckinLate
   */
  callWhat1601(Map<String, dynamic> param) async {
    try {
      var what = 1601;

      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          listCheckinLate1601.addAll(value);
        }else{
          listCheckinLate1601 = [];
        }
      }).whenComplete(() {
        _checkinLateSubject1601.sink.add(listCheckinLate1601);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**                                                                                                                                                                                           
   * callWhat1605 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat1605(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 1605;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listCheckinLate1605 = [];                                                                                                                               
            _listCheckinLate1605.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listCheckinLate1605.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _checkinLateSubject1605.sink.add(_listCheckinLate1605);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }

  /**
   * callWhat1613 get data to detail
   */
  callWhat1613(Map<String, dynamic> param) async {
    try {
      var what = 1613;

      await _repository.executeService(what, param).then((value) {
        listCheckinLate1613 = value;
      }).whenComplete(() {
        _checkinLateSubject1613.sink.add(listCheckinLate1613);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}                                                                                                                                                                                               

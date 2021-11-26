import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class OvertimeBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 1800                                                                                                                                                                  
  List<M1800OvertimeModel> _listOvertime1800 = [];                                                                                      
  final _overtimeSubject1800 = PublishSubject<List<M1800OvertimeModel>>();                                                        
  Stream<List<M1800OvertimeModel>> get overtimeStream1800 => _overtimeSubject1800.stream;       
																																																
  // for what 1805                                                                                                                                                                
  List<M1800OvertimeModel> _listOvertime1805 = [];                                                                                    
  final _overtimeSubject1805 = PublishSubject<List<M1800OvertimeModel>>();
  Stream<List<M1800OvertimeModel>> get overtimeStream1805 => _overtimeSubject1805.stream;

  // for what 1808
  var countOvertime1808;
  final _overtimeSubject1808 = PublishSubject();
  Stream get overtimeStream1808 => _overtimeSubject1808.stream;

  // for what 1813
  var listOvertime1813 = [];
  final _overtimeSubject1813 = PublishSubject();
  Stream get overtimeStream1813 => _overtimeSubject1813.stream;
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _overtimeSubject1800.close();                                                                                                                             
    _overtimeSubject1805.close();
    _overtimeSubject1808.close();
    _overtimeSubject1813.close();
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1800 get all data Overtime                                                                                                                             
   */                                                                                                                                                                                           
  callWhat1800() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 1800;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listOvertime1800.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listOvertime1800 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _overtimeSubject1800.sink.add(_listOvertime1800);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1805 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat1805(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 1805;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listOvertime1805 = [];                                                                                                                               
            _listOvertime1805.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listOvertime1805.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _overtimeSubject1805.sink.add(_listOvertime1805);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }

  /**
   * callWhat1808 get all data Overtime
   */
//  callWhat1808(Map<String, dynamic> param) async {
//    try {
//      var what = 1808;
//
//      await _repository.executeService(what, param).then((value) {
//        countOvertime1808 = value['data'][0]['COUNT(1)'];
//      }).whenComplete(() {
//        _overtimeSubject1808.sink.add([]);
//      });
//    } catch (e) {
//      print(e);
//      throw e;
//    }
//  }

  callWhat1813(Map<String, dynamic> param) async {
    try {
      var what = 1813;

      await _repository.executeService(what, param).then((value) {
        listOvertime1813 = value;
      }).whenComplete(() {
        _overtimeSubject1813.sink.add(listOvertime1813);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}                                                                                                                                                                                               

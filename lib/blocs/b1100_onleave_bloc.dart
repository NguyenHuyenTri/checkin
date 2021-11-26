import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class OnLeaveBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 1100                                                                                                                                                                  
  List<M1100OnLeaveModel> _listOnLeave1100 = [];                                                                                      
  final _onLeaveSubject1100 = PublishSubject<List<M1100OnLeaveModel>>();                                                        
  Stream<List<M1100OnLeaveModel>> get onLeaveStream1100 => _onLeaveSubject1100.stream;       
																																																
  // for what 1105                                                                                                                                                                
  List<M1100OnLeaveModel> _listOnLeave1105 = [];                                                                                    
  final _onLeaveSubject1105 = PublishSubject<List<M1100OnLeaveModel>>();                                                      
  Stream<List<M1100OnLeaveModel>> get onLeaveStream1105 => _onLeaveSubject1105.stream;   

  // for what 1108
  var countNotHaveOnLeave1108;
  var countStandardOLeave1108;
  final _onLeaveSubject1108 = PublishSubject();
  Stream get onLeaveStream1108 => _onLeaveSubject1108.stream;

  var listOnLeave1115 = [];
  final _onLeaveSubject1115 = PublishSubject();
  Stream get onLeaveStream1115 => _onLeaveSubject1115.stream;

  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _onLeaveSubject1100.close();                                                                                                                             
    _onLeaveSubject1105.close();
    _onLeaveSubject1108.close();
    _onLeaveSubject1115.close();
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1100 get all data OnLeave                                                                                                                             
   */                                                                                                                                                                                           
  callWhat1100() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 1100;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listOnLeave1100.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listOnLeave1100 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _onLeaveSubject1100.sink.add(_listOnLeave1100);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }

  /*
  * delete data
  * */
  callWhat1103(Map<String, dynamic> param) async {
    try {
      var what = 1103;

      await _repository.executeService(what, param).then((value) {

      }).whenComplete(() {
        _onLeaveSubject1100.sink.add(_listOnLeave1100);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**                                                                                                                                                                                           
   * callWhat1105 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat1105(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 1105;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listOnLeave1105 = [];                                                                                                                               
            _listOnLeave1105.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listOnLeave1105.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _onLeaveSubject1105.sink.add(_listOnLeave1105);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }

  /**
   *  dem so ngay nghi khong luonng va ngay nghi tieu chuan
   */
  callWhat1108(Map<String, dynamic> param) async {
    try {
      var what = 1108;

      await _repository.executeService(what, param).then((value) {
        // count total requests waiting approve
        countNotHaveOnLeave1108 =
        value['not_have_on_leave']['data'][0]['NotHaveOnLeave'];
        countStandardOLeave1108 =
        value['standard_on_leave']['data'][0]['StandardOnLeave'];
        print(countNotHaveOnLeave1108.toString());
        print(countStandardOLeave1108.toString());
      }).whenComplete(() {
        _onLeaveSubject1108.sink.add([
          countNotHaveOnLeave1108,
          countStandardOLeave1108
        ]);
      });
    } catch (e) {
      if (e.toString().contains("No address associated with hostname")) {
        print('1108: Không có kết nối!');
      } else {
        throw e;
      }
    }
  }

  /**
   * callWhat1115 get all data OnLeave
   */
  callWhat1115(Map<String, dynamic> param) async {
    try {
      var what = 1115;

      await _repository.executeService(what, param).then((value) {
        listOnLeave1115 = value;
        print('Break point 1115 list bloc ' + value.toString());
      }).whenComplete(() {
        _onLeaveSubject1115.sink.add(listOnLeave1115);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}                                                                                                                                                                                               

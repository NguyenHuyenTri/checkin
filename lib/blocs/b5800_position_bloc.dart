import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class PositionBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 5800                                                                                                                                                                  
  List<M5800PositionModel> _listPosition5800 = [];                                                                                      
  final _positionSubject5800 = PublishSubject<List<M5800PositionModel>>();                                                        
  Stream<List<M5800PositionModel>> get positionStream5800 => _positionSubject5800.stream;       
																																																
  // for what 5805                                                                                                                                                                
  List<M5800PositionModel> _listPosition5805 = [];                                                                                    
  final _positionSubject5805 = PublishSubject<List<M5800PositionModel>>();                                                      
  Stream<List<M5800PositionModel>> get positionStream5805 => _positionSubject5805.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _positionSubject5800.close();                                                                                                                             
    _positionSubject5805.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5800 get all data Position                                                                                                                             
   */                                                                                                                                                                                           
  callWhat5800() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 5800;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listPosition5800.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listPosition5800 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _positionSubject5800.sink.add(_listPosition5800);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5805 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat5805(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 5805;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listPosition5805 = [];                                                                                                                               
            _listPosition5805.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listPosition5805.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _positionSubject5805.sink.add(_listPosition5805);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

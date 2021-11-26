import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class BusinessTripBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 1700                                                                                                                                                                  
  List<M1700BusinessTripModel> _listBusinessTrip1700 = [];                                                                                      
  final _businessTripSubject1700 = PublishSubject<List<M1700BusinessTripModel>>();                                                        
  Stream<List<M1700BusinessTripModel>> get businessTripStream1700 => _businessTripSubject1700.stream;       
																																																
  // for what 1705                                                                                                                                                                
  List<M1700BusinessTripModel> _listBusinessTrip1705 = [];                                                                                    
  final _businessTripSubject1705 = PublishSubject<List<M1700BusinessTripModel>>();                                                      
  Stream<List<M1700BusinessTripModel>> get businessTripStream1705 => _businessTripSubject1705.stream;

  // for what 1705
  var listBusinessTrip1709 = [];
  final _businessTripSubject1709 = PublishSubject();
  Stream get businessTripStream1709 => _businessTripSubject1709.stream;


  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _businessTripSubject1700.close();                                                                                                                             
    _businessTripSubject1705.close();
    _businessTripSubject1709.close();
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1700 get all data BusinessTrip                                                                                                                             
   */                                                                                                                                                                                           
  callWhat1700() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 1700;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listBusinessTrip1700.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listBusinessTrip1700 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _businessTripSubject1700.sink.add(_listBusinessTrip1700);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1705 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat1705(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 1705;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listBusinessTrip1705 = [];                                                                                                                               
            _listBusinessTrip1705.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listBusinessTrip1705.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _businessTripSubject1705.sink.add(_listBusinessTrip1705);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }

  /**
   * callWhat1709 get all data BusinessTrip to detail
   */
  callWhat1709(Map<String, dynamic> param) async {
    try {
      var what = 1709;

      await _repository.executeService(what, param).then((value) {
        listBusinessTrip1709 = value;
      }).whenComplete(() {
        _businessTripSubject1709.sink.add(listBusinessTrip1709);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}                                                                                                                                                                                               

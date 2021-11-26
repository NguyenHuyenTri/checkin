import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class CheckoutSoonBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 1500                                                                                                                                                                  
  List<M1500CheckoutSoonModel> _listCheckoutSoon1500 = [];                                                                                      
  final _checkoutSoonSubject1500 = PublishSubject<List<M1500CheckoutSoonModel>>();                                                        
  Stream<List<M1500CheckoutSoonModel>> get checkoutSoonStream1500 => _checkoutSoonSubject1500.stream;       
																																																
  // for what 1505                                                                                                                                                                
  List<M1500CheckoutSoonModel> _listCheckoutSoon1505 = [];                                                                                    
  final _checkoutSoonSubject1505 = PublishSubject<List<M1500CheckoutSoonModel>>();                                                      
  Stream<List<M1500CheckoutSoonModel>> get checkoutSoonStream1505 => _checkoutSoonSubject1505.stream;

  // for what 1513
  var listCheckoutSoon1513 = [];
  final _checkoutSoonSubject1513 = PublishSubject();
  Stream get checkoutSoonStream1513 => _checkoutSoonSubject1513.stream;

  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _checkoutSoonSubject1500.close();                                                                                                                             
    _checkoutSoonSubject1505.close();
    _checkoutSoonSubject1513.close();
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1500 get all data CheckoutSoon                                                                                                                             
   */                                                                                                                                                                                           
  callWhat1500() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 1500;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listCheckoutSoon1500.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listCheckoutSoon1500 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _checkoutSoonSubject1500.sink.add(_listCheckoutSoon1500);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat1505 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat1505(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 1505;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listCheckoutSoon1505 = [];                                                                                                                               
            _listCheckoutSoon1505.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listCheckoutSoon1505.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _checkoutSoonSubject1505.sink.add(_listCheckoutSoon1505);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }

  /**
   * callWhat1503 get all data CheckoutSoon to detail
   */
  callWhat1513(Map<String, dynamic> param) async {
    try {
      var what = 1513;

      await _repository.executeService(what, param).then((value) {
        listCheckoutSoon1513 = value;
      }).whenComplete(() {
        _checkoutSoonSubject1513.sink.add(listCheckoutSoon1513);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}                                                                                                                                                                                               

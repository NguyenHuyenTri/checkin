import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class InformationBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 400                                                                                                                                                                  
  List<M400InformationModel> _listInformation400 = [];
  final _informationSubject400 = PublishSubject<List<M400InformationModel>>();                                                        
  Stream<List<M400InformationModel>> get informationStream400 => _informationSubject400.stream;       
																																																
  // for what 405                                                                                                                                                                
  List<M400InformationModel> _listInformation405 = [];                                                                                    
  final _informationSubject405 = PublishSubject<List<M400InformationModel>>();                                                      
  Stream<List<M400InformationModel>> get informationStream405 => _informationSubject405.stream;
  // for what 407
  List listInformation407 = [];
  final informationSubject407 = PublishSubject();
  Stream get informationStream407 => informationSubject407.stream;
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _informationSubject400.close();                                                                                                                             
    _informationSubject405.close();
    informationSubject407.close();
    }
																																																
  /**                                                                                                                                                                                           
   * callWhat400 get all data Information                                                                                                                             
   */                                                                                                                                                                                           
  callWhat400() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 400;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listInformation400.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listInformation400 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _informationSubject400.sink.add(_listInformation400);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat405 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat405(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 405;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listInformation405 = [];                                                                                                                               
            _listInformation405.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listInformation405.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _informationSubject405.sink.add(_listInformation405);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }

  callWhat407(Map<String ,dynamic> param) async {
    try {
      var what = 407;
      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          listInformation407=value;
          print(value.toString()+'llllllll');
        }else{
          listInformation407 = [];
        }
      }).whenComplete(() {
        informationSubject407.sink.add(listInformation407);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}                                                                                                                                                                                               

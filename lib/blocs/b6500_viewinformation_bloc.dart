import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class ViewInformationBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 6500                                                                                                                                                                  
  List<M6500ViewInformationModel> _listViewInformation6500 = [];                                                                                      
  final _viewInformationSubject6500 = PublishSubject<List<M6500ViewInformationModel>>();                                                        
  Stream<List<M6500ViewInformationModel>> get viewInformationStream6500 => _viewInformationSubject6500.stream;       
																																																
  // for what 6505                                                                                                                                                                
  List<M6500ViewInformationModel> _listViewInformation6505 = [];                                                                                    
  final _viewInformationSubject6505 = PublishSubject<List<M6500ViewInformationModel>>();                                                      
  Stream<List<M6500ViewInformationModel>> get viewInformationStream6505 => _viewInformationSubject6505.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _viewInformationSubject6500.close();                                                                                                                             
    _viewInformationSubject6505.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6500 get all data ViewInformation                                                                                                                             
   */                                                                                                                                                                                           
  callWhat6500() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 6500;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listViewInformation6500.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listViewInformation6500 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _viewInformationSubject6500.sink.add(_listViewInformation6500);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat6505 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat6505(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 6505;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listViewInformation6505 = [];                                                                                                                               
            _listViewInformation6505.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listViewInformation6505.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _viewInformationSubject6505.sink.add(_listViewInformation6505);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class PersonalIncomeTaxTypeBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 3800                                                                                                                                                                  
  List<M3800PersonalIncomeTaxTypeModel> _listPersonalIncomeTaxType3800 = [];                                                                                      
  final _personalIncomeTaxTypeSubject3800 = PublishSubject<List<M3800PersonalIncomeTaxTypeModel>>();                                                        
  Stream<List<M3800PersonalIncomeTaxTypeModel>> get personalIncomeTaxTypeStream3800 => _personalIncomeTaxTypeSubject3800.stream;       
																																																
  // for what 3805                                                                                                                                                                
  List<M3800PersonalIncomeTaxTypeModel> _listPersonalIncomeTaxType3805 = [];                                                                                    
  final _personalIncomeTaxTypeSubject3805 = PublishSubject<List<M3800PersonalIncomeTaxTypeModel>>();                                                      
  Stream<List<M3800PersonalIncomeTaxTypeModel>> get personalIncomeTaxTypeStream3805 => _personalIncomeTaxTypeSubject3805.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _personalIncomeTaxTypeSubject3800.close();                                                                                                                             
    _personalIncomeTaxTypeSubject3805.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3800 get all data PersonalIncomeTaxType                                                                                                                             
   */                                                                                                                                                                                           
  callWhat3800() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 3800;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listPersonalIncomeTaxType3800.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listPersonalIncomeTaxType3800 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _personalIncomeTaxTypeSubject3800.sink.add(_listPersonalIncomeTaxType3800);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3805 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat3805(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 3805;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listPersonalIncomeTaxType3805 = [];                                                                                                                               
            _listPersonalIncomeTaxType3805.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listPersonalIncomeTaxType3805.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _personalIncomeTaxTypeSubject3805.sink.add(_listPersonalIncomeTaxType3805);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

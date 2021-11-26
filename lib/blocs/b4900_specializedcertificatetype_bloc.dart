import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class SpecializedCertificateTypeBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 4900                                                                                                                                                                  
  List<M4900SpecializedCertificateTypeModel> _listSpecializedCertificateType4900 = [];                                                                                      
  final _specializedCertificateTypeSubject4900 = PublishSubject<List<M4900SpecializedCertificateTypeModel>>();                                                        
  Stream<List<M4900SpecializedCertificateTypeModel>> get specializedCertificateTypeStream4900 => _specializedCertificateTypeSubject4900.stream;       
																																																
  // for what 4905                                                                                                                                                                
  List<M4900SpecializedCertificateTypeModel> _listSpecializedCertificateType4905 = [];                                                                                    
  final _specializedCertificateTypeSubject4905 = PublishSubject<List<M4900SpecializedCertificateTypeModel>>();                                                      
  Stream<List<M4900SpecializedCertificateTypeModel>> get specializedCertificateTypeStream4905 => _specializedCertificateTypeSubject4905.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _specializedCertificateTypeSubject4900.close();                                                                                                                             
    _specializedCertificateTypeSubject4905.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4900 get all data SpecializedCertificateType                                                                                                                             
   */                                                                                                                                                                                           
  callWhat4900() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 4900;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listSpecializedCertificateType4900.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listSpecializedCertificateType4900 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _specializedCertificateTypeSubject4900.sink.add(_listSpecializedCertificateType4900);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat4905 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat4905(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 4905;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listSpecializedCertificateType4905 = [];                                                                                                                               
            _listSpecializedCertificateType4905.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listSpecializedCertificateType4905.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _specializedCertificateTypeSubject4905.sink.add(_listSpecializedCertificateType4905);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

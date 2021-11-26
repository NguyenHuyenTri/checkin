import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class SpecializedCertificateBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 5000                                                                                                                                                                  
  List<M5000SpecializedCertificateModel> _listSpecializedCertificate5000 = [];                                                                                      
  final _specializedCertificateSubject5000 = PublishSubject<List<M5000SpecializedCertificateModel>>();                                                        
  Stream<List<M5000SpecializedCertificateModel>> get specializedCertificateStream5000 => _specializedCertificateSubject5000.stream;       
																																																
  // for what 5005                                                                                                                                                                
  List<M5000SpecializedCertificateModel> _listSpecializedCertificate5005 = [];                                                                                    
  final _specializedCertificateSubject5005 = PublishSubject<List<M5000SpecializedCertificateModel>>();                                                      
  Stream<List<M5000SpecializedCertificateModel>> get specializedCertificateStream5005 => _specializedCertificateSubject5005.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _specializedCertificateSubject5000.close();                                                                                                                             
    _specializedCertificateSubject5005.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5000 get all data SpecializedCertificate                                                                                                                             
   */                                                                                                                                                                                           
  callWhat5000() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 5000;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listSpecializedCertificate5000.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listSpecializedCertificate5000 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _specializedCertificateSubject5000.sink.add(_listSpecializedCertificate5000);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat5005 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat5005(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 5005;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listSpecializedCertificate5005 = [];                                                                                                                               
            _listSpecializedCertificate5005.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listSpecializedCertificate5005.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _specializedCertificateSubject5005.sink.add(_listSpecializedCertificate5005);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

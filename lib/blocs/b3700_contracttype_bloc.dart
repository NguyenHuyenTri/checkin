import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class ContractTypeBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 3700                                                                                                                                                                  
  List<M3700ContractTypeModel> _listContractType3700 = [];                                                                                      
  final _contractTypeSubject3700 = PublishSubject<List<M3700ContractTypeModel>>();                                                        
  Stream<List<M3700ContractTypeModel>> get contractTypeStream3700 => _contractTypeSubject3700.stream;       
																																																
  // for what 3705                                                                                                                                                                
  List<M3700ContractTypeModel> _listContractType3705 = [];                                                                                    
  final _contractTypeSubject3705 = PublishSubject<List<M3700ContractTypeModel>>();                                                      
  Stream<List<M3700ContractTypeModel>> get contractTypeStream3705 => _contractTypeSubject3705.stream;   
																																																
  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _contractTypeSubject3700.close();                                                                                                                             
    _contractTypeSubject3705.close();                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3700 get all data ContractType                                                                                                                             
   */                                                                                                                                                                                           
  callWhat3700() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 3700;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listContractType3700.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listContractType3700 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _contractTypeSubject3700.sink.add(_listContractType3700);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3705 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat3705(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 3705;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listContractType3705 = [];                                                                                                                               
            _listContractType3705.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listContractType3705.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _contractTypeSubject3705.sink.add(_listContractType3705);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
}                                                                                                                                                                                               

import '../models/models.dart';                                                                                                                                                    
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class ShiftAssignmentBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 3000                                                                                                                                                                  
  List<M3000ShiftAssignmentModel> _listShiftAssignment3000 = [];                                                                                      
  final _shiftAssignmentSubject3000 = PublishSubject<List<M3000ShiftAssignmentModel>>();                                                        
  Stream<List<M3000ShiftAssignmentModel>> get shiftAssignmentStream3000 => _shiftAssignmentSubject3000.stream;       
																																																
  // for what 3005                                                                                                                                                                
  List<M3000ShiftAssignmentModel> _listShiftAssignment3005 = [];                                                                                    
  final _shiftAssignmentSubject3005 = PublishSubject<List<M3000ShiftAssignmentModel>>();                                                      
  Stream<List<M3000ShiftAssignmentModel>> get shiftAssignmentStream3005 => _shiftAssignmentSubject3005.stream;   

  // for what 3007
  List<M3000ShiftAssignmentModel> listShiftAssignment3007 = [];
  final _shiftAssignmentSubject3007 = PublishSubject<List<M3000ShiftAssignmentModel>>();
  Stream<List<M3000ShiftAssignmentModel>> get shiftAssignmentStream3007 => _shiftAssignmentSubject3007.stream;

  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _shiftAssignmentSubject3000.close();                                                                                                                             
    _shiftAssignmentSubject3005.close();
    _shiftAssignmentSubject3007.close();
  }
																																																
  /**                                                                                                                                                                                           
   * callWhat3000 get all data ShiftAssignment                                                                                                                             
   */                                                                                                                                                                                           
  callWhat3000() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 3000;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listShiftAssignment3000.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listShiftAssignment3000 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _shiftAssignmentSubject3000.sink.add(_listShiftAssignment3000);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             
																																																
  /**                                                                                                                                                                                           
   * callWhat3005 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat3005(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 3005;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listShiftAssignment3005 = [];                                                                                                                               
            _listShiftAssignment3005.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listShiftAssignment3005.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _shiftAssignmentSubject3005.sink.add(_listShiftAssignment3005);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }
  /**
   * callWhat3005 get data limit
   * @page : number pagination
   * @limit : limit of pagination
   * @isPullRefresh: default is false
   */
  callWhat3007(String idCompany, String idEmployee, String idDepartment, String idBranch) async {
    try {
      var what = 3007;
      var param = {"IdCompany": int.parse(idCompany), "IdEmployee": int.parse(idEmployee), "IdDepartment": int.parse(idDepartment), "IdBranch": int.parse(idBranch)};
      print('param ${param}');
      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          listShiftAssignment3007.addAll(value);
        }else{
          listShiftAssignment3007 = [];
        }
      }).whenComplete(() {
        _shiftAssignmentSubject3007.sink.add(listShiftAssignment3007);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

}                                                                                                                                                                                               

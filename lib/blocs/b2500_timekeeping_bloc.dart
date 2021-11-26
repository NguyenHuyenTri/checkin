import 'dart:convert';

import 'package:vao_ra/helpers/dioultibaohq.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';                                                                                                                                        
import 'package:rxdart/rxdart.dart';                                                                                                                                                          
																																																
class TimekeepingBloc {                                                                                                                                                            
  final _repository = Repository();                                                                                                                                                             
																																																
  // for what 2500                                                                                                                                                                  
  List<M2500TimekeepingModel> _listTimekeeping2500 = [];                                                                                      
  final _timekeepingSubject2500 = PublishSubject<List<M2500TimekeepingModel>>();                                                        
  Stream<List<M2500TimekeepingModel>> get timekeepingStream2500 => _timekeepingSubject2500.stream;       
																																																
  // for what 2501
  List<M2500TimekeepingModel> listTimekeeping2501 = [];
  final _timekeepingSubject2501 = PublishSubject<List<M2500TimekeepingModel>>();
  Stream<List<M2500TimekeepingModel>> get timekeepingStream2501 => _timekeepingSubject2501.stream;

  // for what 2505
  List<M2500TimekeepingModel> _listTimekeeping2505 = [];
  final _timekeepingSubject2505 = PublishSubject<List<M2500TimekeepingModel>>();
  Stream<List<M2500TimekeepingModel>> get timekeepingStream2505 => _timekeepingSubject2505.stream;

  // for what 2507
  List<M2500TimekeepingModel> listTimekeeping2507 = [];
  final _timekeepingSubject2507 = PublishSubject<List<M2500TimekeepingModel>>();
  Stream<List<M2500TimekeepingModel>> get timekeepingStream2507 => _timekeepingSubject2507.stream;

  // for what 2508
  List<M2500TimekeepingModel> listTimekeeping2508 = [];
  final _timekeepingSubject2508 = PublishSubject<List<M2500TimekeepingModel>>();
  Stream<List<M2500TimekeepingModel>> get timekeepingStream2508 => _timekeepingSubject2508.stream;

  // for what 2509
  List<M2500TimekeepingModel> listTimekeeping2509 = [];
  final _timekeepingSubject2509 = PublishSubject<List<M2500TimekeepingModel>>();
  Stream<List<M2500TimekeepingModel>> get timekeepingStream2509 => _timekeepingSubject2509.stream;

  // for what 25099
  List<String> listTimekeeping25099 = [];
  final _timekeepingSubject25099 = PublishSubject<List<String>>();
  Stream<List<String>> get timekeepingStream25099 => _timekeepingSubject25099.stream;

  var listTimeKeeping2510 = [];
  final _timeKeepingSubject2510 = PublishSubject();
  Stream get timeKeepingStream2510 => _timeKeepingSubject2510.stream;

  /**                                                                                                                                                                                           
   * dispose subject                                                                                                                                                                            
   */                                                                                                                                                                                           
  void dispose() {                                                                                                                                                                              
    _timekeepingSubject2500.close();                                                                                                                             
    _timekeepingSubject2501.close();
    _timekeepingSubject2505.close();
    _timekeepingSubject2507.close();
    _timekeepingSubject2508.close();
    _timekeepingSubject2509.close();
    _timeKeepingSubject2510.close();
  }
																																																
  /**                                                                                                                                                                                           
   * callWhat2500 get all data Timekeeping                                                                                                                             
   */                                                                                                                                                                                           
  callWhat2500() async {                                                                                                                                                            
    try {                                                                                                                                                                                       
      var what = 2500;                                                                                                                                                              
																																																
      await _repository.executeService(what, {}).then((value) {                                                                                                                                 
        if (value.length != 0) {                                                                                                                                                                
          _listTimekeeping2500.addAll(value);                                                                                                                          
        }else{                                                                                                                                                                                  
          _listTimekeeping2500 = [];                                                                                                                                   
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _timekeepingSubject2500.sink.add(_listTimekeeping2500);                                                                         
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }                                                                                                                                                                                             

  /**
   * callWhat2501 insert
   */
  callWhat2501(param) async {
    try {
      var what = 2501;

      await _repository.executeService(what, param).then((value) {
        print('callWhat2501 value ${callWhat2501}');
        if (value.length != 0) {
          listTimekeeping2501.addAll(value);
        }else{
          listTimekeeping2501 = [];
        }
      }).whenComplete(() {
        _timekeepingSubject2501.sink.add(listTimekeeping2501);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**                                                                                                                                                                                           
   * callWhat2505 get data limit                                                                                                                                                  
   * @page : number pagination                                                                                                                                                                  
   * @limit : limit of pagination                                                                                                                                                               
   * @isPullRefresh: default is false                                                                                                                                                           
   */                                                                                                                                                                                           
  callWhat2505(int page, int limit, {bool isPullRefresh : false}) async {                                                                                                         
    try {                                                                                                                                                                                       
      var what = 2505;                                                                                                                                                            
      var param = {"offset": page * limit, "limit": limit};                                                                                                                                     
																																																
      await _repository.executeService(what, param).then((value) {                                                                                                                              
        if (value.length != 0) {                                                                                                                                                                
          // clear data when pull refresh                                                                                                                                                       
          if (isPullRefresh == true) {                                                                                                                                                          
            _listTimekeeping2505 = [];                                                                                                                               
            _listTimekeeping2505.addAll(value);                                                                                                                      
          } else {                                                                                                                                                                              
            // add more data                                                                                                                                                                    
            _listTimekeeping2505.addAll(value);                                                                                                                      
          }                                                                                                                                                                                     
        }                                                                                                                                                                                       
      }).whenComplete(() {                                                                                                                                                                      
        _timekeepingSubject2505.sink.add(_listTimekeeping2505);                                                                     
      });                                                                                                                                                                                       
    } catch (e) {                                                                                                                                                                               
      print(e);                                                                                                                                                                                 
      throw e;                                                                                                                                                                                  
    }                                                                                                                                                                                           
  }

  /**
   * callWhat2507 check has checkin
   */
  callWhat2507(param) async {
    try {
      var what = 2507;
      print('Go callWhat2507 ${param}  ${what} ');

      await _repository.executeService(what, param).then((value) {

        print('callWhat2507 value ${value}');
        if (value.length != 0) {
          listTimekeeping2507 = [];
          listTimekeeping2507.addAll(value);
        }else{
          listTimekeeping2507 = [];
        }
      }).whenComplete(() {
        _timekeepingSubject2507.sink.add(listTimekeeping2507);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat2508 checkout normal
   */
  callWhat2508(param) async {
    try {
      var what = 2508;
      print('Go callWhat2508 ${param}  ${what} ');

      await _repository.executeService(what, param).then((value) {

        print('callWhat2508 value ${value}');
        if (value.length != 0) {
          listTimekeeping2508.addAll(value);
        }else{
          listTimekeeping2508 = [];
        }
      }).whenComplete(() {
        _timekeepingSubject2508.sink.add(listTimekeeping2508);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat2508 checkout normal
   */
  callWhat2509(param) async {
    try {
      var what = 2509;
      print('Go callWhat2509 ${param}  ${what} ');

      await _repository.executeService(what, param).then((value) {

        print('callWhat2509 value ${value}');
        if (value.length != 0) {
          listTimekeeping2509.addAll(value);
        }else{
          listTimekeeping2509 = [];
        }
      }).whenComplete(() {
        _timekeepingSubject2509.sink.add(listTimekeeping2509);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat2508 checkout normal
   */
  callWhat25099(file, mimeType) async {
    try {
      var what = 2509;
      print('Go callWhat25099 uplaod image');


      final response = await DioUtilBaohq.uploadImageFaceCheckin(
          file, mimeType);

      print('response upload image  ${response}');

      listTimekeeping25099 = [];
      listTimekeeping25099.addAll(response);
      _timekeepingSubject25099.sink.add(listTimekeeping25099);
      // Map<String, dynamic> result = jsonDecode(response.toString());

      // print('result upload image  ${result}');
      // if (result['status'] == true) {
      //   return List<M400InformationModel>.from(
      //       result['data'].map((model) => M400InformationModel.fromJson(model)));
      // } else {
      //   throw Exception(result['error']);
      // }
      // await _repository.executeService(what, param).then((value) {
      //
      //   print('callWhat2509 value ${value}');
      //   if (value.length != 0) {
      //     listTimekeeping2509.addAll(value);
      //   }else{
      //     listTimekeeping2509 = [];
      //   }
      // }).whenComplete(() {
      //   _timekeepingSubject2509.sink.add(listTimekeeping2509);
      // });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat2300 get all data AdvanceSalary
   */
  callWhat2510(Map<String, dynamic> param) async {
    try {
      var what = 2510;

      await _repository.executeService(what, param).then((value) {
        listTimeKeeping2510.clear();

        listTimeKeeping2510 = value;
        print(listTimeKeeping2510.toString());
      }).whenComplete(() {
        _timeKeepingSubject2510.sink.add(listTimeKeeping2510);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

}                                                                                                                                                                                               

import '../models/models.dart';
import '../repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class CompanyBloc {
  final _repository = Repository();

  // for what 3400
//  List<String> companyNameList = [];
  List<M3400CompanyModel> listCompany3400 = [];
  final _companySubject3400 = PublishSubject<List<M3400CompanyModel>>();
  Stream<List<M3400CompanyModel>> get companyStream3400 =>
      _companySubject3400.stream;

  // for what 3405
  List<M3400CompanyModel> _listCompany3405 = [];
  final _companySubject3405 = PublishSubject<List<M3400CompanyModel>>();
  Stream<List<M3400CompanyModel>> get companyStream3405 =>
      _companySubject3405.stream;

  // for what 3407
  List<String> companyNameList = [];
  List<M3400CompanyModel> listCompany3407 = [];
  final _companySubject3407 = PublishSubject<List<M3400CompanyModel>>();
  Stream<List<M3400CompanyModel>> get companyStream3407 =>
      _companySubject3407.stream;

  /**
   * dispose subject
   */
  void dispose() {
    _companySubject3400.close();
    _companySubject3405.close();
    _companySubject3407.close();
  }

  /**
   * callWhat3400 get all data Company
   */
  callWhat3400() async {
    try {
      var what = 3400;

      await _repository.executeService(what, {}).then((value) {
        listCompany3400 = List<M3400CompanyModel>.from(
            value.map((model) => M3400CompanyModel.fromJson(model)));
        print("Get list company");
      }).whenComplete(() {
        _companySubject3400.sink.add(listCompany3400);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat3405 get data limit
   * @page : number pagination
   * @limit : limit of pagination
   * @isPullRefresh: default is false
   */
  callWhat3405(int page, int limit, {bool isPullRefresh: false}) async {
    try {
      var what = 3405;
      var param = {"offset": page * limit, "limit": limit};

      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          // clear data when pull refresh
          if (isPullRefresh == true) {
            _listCompany3405 = [];
            _listCompany3405.addAll(value);
          } else {
            // add more data
            _listCompany3405.addAll(value);
          }
        }
      }).whenComplete(() {
        _companySubject3405.sink.add(_listCompany3405);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat3407 get data data Company
   */
  callWhat3407() async {
    try {
      var what = 3407;

      await _repository.executeService(what, {}).then((value) {
        listCompany3407 = List<M3400CompanyModel>.from(
            value.map((model) => M3400CompanyModel.fromJson(model)));
        print("Get list company");
      }).whenComplete(() {
        _companySubject3407.sink.add(listCompany3407);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

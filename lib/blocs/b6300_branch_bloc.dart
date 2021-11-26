import '../models/models.dart';
import '../repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class BranchBloc {
  final _repository = Repository();

  // for what 6300
  List<M6300BranchModel> listBranch6300 = [];
  final _branchSubject6300 = PublishSubject<List<M6300BranchModel>>();
  Stream<List<M6300BranchModel>> get branchStream6300 =>
      _branchSubject6300.stream;

  // for what 6305
  List<M6300BranchModel> _listBranch6305 = [];
  final _branchSubject6305 = PublishSubject<List<M6300BranchModel>>();
  Stream<List<M6300BranchModel>> get branchStream6305 =>
      _branchSubject6305.stream;

  /**
   * dispose subject
   */
  void dispose() {
    _branchSubject6300.close();
    _branchSubject6305.close();
  }

  /**
   * callWhat6300 get all data Branch
   */
  callWhat6300() async {
    try {
      var what = 6300;

      await _repository.executeService(what, {}).then((value) {
        if (value.length != 0) {
          listBranch6300 = List<M6300BranchModel>.from(
              value.map((model) => M6300BranchModel.fromJson(model)));
        } else {
          listBranch6300 = [];
        }
      }).whenComplete(() {
        _branchSubject6300.sink.add(listBranch6300);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat6305 get data limit
   * @page : number pagination
   * @limit : limit of pagination
   * @isPullRefresh: default is false
   */
  callWhat6305(int page, int limit, {bool isPullRefresh: false}) async {
    try {
      var what = 6305;
      var param = {"offset": page * limit, "limit": limit};

      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          // clear data when pull refresh
          if (isPullRefresh == true) {
            _listBranch6305 = [];
            _listBranch6305.addAll(value);
          } else {
            // add more data
            _listBranch6305.addAll(value);
          }
        }
      }).whenComplete(() {
        _branchSubject6305.sink.add(_listBranch6305);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

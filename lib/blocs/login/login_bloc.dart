// lib/blocs/login/login_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:vao_ra/repositories/auth_prodiver.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../authentication/authentication.dart';
import '../../exceptions/exceptions.dart';

class LoginBlocBaohq extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthProvider _authenticationService;

  LoginBlocBaohq(AuthenticationBloc authenticationBloc, AuthProvider authenticationService)
      : assert(authenticationBloc != null),
        assert(authenticationService != null),
        _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithUsernameButtonPressed) {
      yield* _mapLoginWithUsernamePasswordToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithUsernamePasswordToState(LoginInWithUsernameButtonPressed event) async* {
    print('_mapLoginWithUsernamePasswordToState 1');
    print(event);
    print('_mapLoginWithUsernamePasswordToState 1');
    yield LoginLoading();
    try {
      final user = await _authenticationService.signInWithUsernamePassword(event.username, event.password);
      if (user != null) {
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Có lỗi đã xảy ra');
      }
    } on AuthenticationException catch (e) {
      yield LoginFailure(error: e.message);
    } catch (err) {
      yield LoginFailure(error: 'Lỗi đăng nhập');
    }
  }
}


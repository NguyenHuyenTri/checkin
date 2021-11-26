// lib/blocs/authentication/authentication_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:vao_ra/repositories/auth_prodiver.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthProvider _authenticationService;

  AuthenticationBloc(AuthProvider authenticationService)
      : assert(authenticationService != null),
        _authenticationService = authenticationService,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationLoading();
    try {
      await Future.delayed(Duration(milliseconds: 500)); // a simulated delay
      final loginToken = await _authenticationService.getCurrentToken();
      final currentUser = await _authenticationService.getCurrentUser();
      final currentCompany = await _authenticationService.getCurrentCompany();
      print("loginToken");
      print(loginToken);
      print("currentUser");
      print(currentUser);
      print("currentCompany");
      print(currentCompany);
      if (currentUser != null && currentCompany == null) {
        print('Here 1');
        yield AuthenticationAuthenticatedNeedChooseCompany();
      }
      else if (currentUser != null && currentCompany != null) {
        print('Here 2');
        yield AuthenticationAuthenticated();
      } else {
        print('Here 3');
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      print('Here 4 ${e}');
      yield AuthenticationFailure(message: 'An unknown error occurred');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(UserLoggedIn event) async* {
    // yield AuthenticationAuthenticated(user: event.user);
    yield AuthenticationAuthenticatedNeedChooseCompany();
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(UserLoggedOut event) async* {
    await _authenticationService.signOut();
    yield AuthenticationNotAuthenticated();
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/model/user_model.dart';
import 'package:kutum_cepte_app/core/base/service/auth/auth_service.dart';

import 'package:kutum_cepte_app/core/base/service/user/user_service.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/network/vexana_manager.dart';
import 'package:kutum_cepte_app/feature/main/viewModel/main_view_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._userService, this._authService) : super(const AuthState.unknown()) {
    Future<void> saveToken(String? token) async {
      await _authService.updateToken(token);
    }

    Future<void> clearToken() async {
      await _authService.updateToken(null);
      log(locator<VexanaManager>().options.headers.toString());
    }

    Future<void> loginError(Emitter<AuthState> emit, Object e) async {
      await clearToken();

      emit(AuthState.error());
    }

    on<AppStarted>((event, emit) async {
      try {
        final user = await _userService.fetchCurrentUser();
        if (user == null) {
          emit(const AuthState.unknown());
        } else {
          emit(AuthState.authenticated(user: user));
          await _authService.updateTokenFromStorage();
        }
      } catch (e) {
        emit(const AuthState.unknown());
      }
    });

    on<LoginRequested>((event, emit) async {
      try {
        final response = await _authService.login(phone: event.phone, password: event.password);
        if (response != null) {
          await saveToken(response.data);
          final user = await _userService.fetchCurrentUser();
          emit(AuthState.authenticated(user: user));
        } else {
          emit(AuthState.error(errorMessage: response?.message));
        }
      } catch (e) {
        log('ERORR: $e');
        await loginError(emit, e);
        emit(AuthState.error(errorMessage: e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await clearToken();
      locator<MainViewModel>().clearIndex();
      emit(const AuthState.unknown());
    });

    on<UpdateGlobalBlocUser>((event, emit) async {
      try {
        final user = await _userService.fetchUserById(event.context.read<AuthBloc>().state.user!.id!);
        if (user == null) {
          throw Exception('User not found');
        }
        emit(AuthState.authenticated(user: user));
      } catch (e) {
        emit(AuthState.error());
      }
    });

/*
   
   
    on<LogoutRequested>((event, emit) async {
      try {

        emit(const AuthState.unknown());
      } on SocketException {
        emit(const AuthState.unknown());
      } catch (e) {
        await _loginError(emit, e);
      }
    });

    on<UpdateGlobalBlocUser>((event, emit) async {
      try {
        User? user = _firebaseAuthService.getCurrentUser();

        var profile = await _userService.fetchMyProfile();

        emit(AuthState.authenticated(user: user, profile: profile));
      } on SocketException {
        emit(const AuthState.unknown());
      } catch (e) {
        await _loginError(emit, e);
      }
    });

    on<DeleteAccount>((event, emit) async {
      try {
        await _authService.deleteAccount();
       
        await clearToken();
      } catch (e) {
        await _loginError(emit, e);
      }
    });
  }

 

  Future<void> _loginError(Emitter<AuthState> emit, Object e) async {
    await clearToken();

    emit(AuthState.error());
    log("Error: $state");
  }

  Future<void> _saveToken(User? user) async {
    var token = await user?.getIdToken(true);
    log(token.toString());
    await _authService.updateToken(token);
    await _authService.updateLoggedIn(true);
  }

  Future<void> clearToken() async {
    log("CALISTI ");

    await _firebaseAuthService.signOut();

    await _authService.updateToken(null);
    await _authService.updateLoggedIn(false);
  }

 */
  }
  // ignore: unused_field
  final IUserService _userService;
  final IAuthService _authService;
}

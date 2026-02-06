import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_starter_kit/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'logout_event.dart';
import 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRepository authRepository;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  LogoutBloc({required this.authRepository}) : super(LogoutInitial()) {
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  Future<void> _onLogoutButtonPressed(
    LogoutButtonPressed event,
    Emitter<LogoutState> emit,
  ) async {
    emit(LogoutLoading());

    try {
      // Panggil API logout
      await authRepository.logout();

      // Hapus token dari secure storage
      await secureStorage.delete(key: 'auth_token');

      emit(LogoutSuccess());
    } catch (e) {
      // Meskipun API gagal, tetap hapus token lokal
      await secureStorage.delete(key: 'auth_token');

      emit(LogoutFailure(error: e.toString().replaceAll('Exception: ', '')));
    }
  }
}

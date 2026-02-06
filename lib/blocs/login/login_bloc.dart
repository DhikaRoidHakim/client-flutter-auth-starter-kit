import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_starter_kit/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final data = await authRepository.login(
        email: event.email,
        password: event.password,
      );

      final token = data['token'];

      // Simpan token ke Secure Storage
      await secureStorage.write(key: 'auth_token', value: token);

      // Bisa juga simpan data user lainnya jika perlu atau di repository terpisah
      // Untuk data non-sensitif bisa tetap pakai SharedPreferences jika mau,
      // tapi token wajib di secure storage.

      emit(LoginSuccess(token: token));
    } catch (e) {
      emit(LoginFailure(error: e.toString().replaceAll('Exception: ', '')));
    }
  }
}

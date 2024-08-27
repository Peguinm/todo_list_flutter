import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list/app/repositories/user/user_repository.dart';
import 'package:to_do_list/app/services/user/user_service.dart';

class UserServiceImpl implements UserService {

  final UserRepository _userRepository;

  UserServiceImpl({required UserRepository userRepository}) : _userRepository = userRepository;

  @override
  Future<User?> register({required String email, required String password}) {
    return _userRepository.register(email: email, password: password);
  }

  @override
  Future<User?> login({required String email, required String password}) {
    return _userRepository.login(email: email, password: password);
  }
  
  @override
  Future<void> forgotPassword({required String email}) {
    return _userRepository.forgotPassword(email);
  }
  
  @override
  Future<User?> googleLogin() {
    return _userRepository.googleLogin();
  }
  
  @override
  Future<void> logout() {
    return _userRepository.logout();
  }
  
  @override
  Future<void> changeUsername(String name) {
    return _userRepository.changeUsername(name);
  }

}
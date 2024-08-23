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

}
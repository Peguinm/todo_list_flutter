import 'package:firebase_auth/firebase_auth.dart';

// Essa class é usada como implement AKA interface
// é basicamente um header com todos os métodos virtuais e iguais a 0, ou seja, precisam ser definidos
// vale tbm pras vars e qualquer outra coisa 'definivel' criada aqui
// mas o conceito é esse, polimorfismo em c++

abstract class UserService {

  Future<User?> register({required String email, required String password});

  Future<User?> login({required String email, required String password});

  Future<void> forgotPassword({required String email});

  Future<User?> googleLogin();

  Future<void> logout();

}

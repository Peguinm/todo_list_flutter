import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list/app/exception/auth_exceptions.dart';
import 'package:to_do_list/app/repositories/user/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  //Instância de autenticação
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImp({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(
      {required String email, required String password}) async {
    //tentar registro
    //verificar disponibilidade do email
    //checar tipo de login
    try {
      UserCredential userCredentials = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredentials.user;
    } on FirebaseAuthException catch (e, s) {
      // print(e);
      // print(s);

      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        print(
            'Métodos de login disponíveis: $loginTypes'); // Log para depuração

        if (!loginTypes.contains('google.com')) {
          throw AuthExceptions(
              message: 'O e-mail já está em uso, por favor utilize outro');
        } else {
          throw AuthExceptions(
              message:
                  'Você já possuí um login com o Google, utilize-o para acessar');
        }
      } else {
        throw AuthExceptions(
            message: e.message ?? 'Houve um erro ao se registrar');
      }
    }
  }
}

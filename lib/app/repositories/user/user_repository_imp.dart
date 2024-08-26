import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      print(s);

      if (e.code == 'email-already-in-use') {
        final loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        // print('------------------------------------- Methods: $loginMethods');

        if (loginMethods.contains('password')) {
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

  @override
  Future<User?> login({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e) {
      print(e);
      throw AuthExceptions(message: 'Erro ao realizar login');
    } on FirebaseAuthException catch (e) {
      print(e);
      throw AuthExceptions(message: 'Erro ao realizar login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);

      print('------------------------------------- Methods: $loginMethods');

      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else {
        throw AuthExceptions(
            message:
                'Não é possível recuperar a senha para cadastros realizados com o Google');
      }
    } on PlatformException catch (e) {
      print(e);
      throw AuthExceptions(message: 'Erro ao redefinir senha');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthExceptions(message: 'Usuário não encontrado');
      } else {
        throw AuthExceptions(message: 'Erro ao redefinir senha');
      }
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;

    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);

        if (loginMethods.contains('password')) {
          throw AuthExceptions(message: 'Login com e-mail e senha vinculado a conta, por favor utilize o login com senha');
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken
          );

          final userCredential = await _firebaseAuth.signInWithCredential(firebaseCredential);
          return userCredential.user;
        }
      } else {
        // throw AuthExceptions(message: 'H')
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthExceptions(message: 
        '''
          Você se concetou com os seguintes provedores:
          ${loginMethods?.join(',')}
        ''');
      }
    }
    return null;
  }
  
  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }
}

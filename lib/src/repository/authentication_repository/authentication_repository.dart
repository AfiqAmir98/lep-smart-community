import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psm_project/src/features/authentication/screens/dashboard/resident_dashboard.dart';
import 'package:psm_project/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:psm_project/src/features/authentication/screens/dashboard/dashboard.dart';

import '../../features/authentication/controllers/signup_controller.dart';
import '../../features/authentication/screens/dashboard/admin_dashboard.dart';
import '../../features/authentication/screens/dashboard/maintenance_dashboard.dart';
import 'exception/signup_email_password_failure.dart';
import 'exception/login_with_email_and_pssword_failure.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  User? get currentUser => _auth.currentUser;


  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;


  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }


  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const WelcomeScreen()) : Get.offAll(() => const MyHomePage());
  }


  //FUNC
  Future<void> createUserWithEmailAndPassword(String email, String password, UserRole role) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailPasswordFailure();
      print('EXCEPTION -${ex.message}');
      throw ex;
    }
  }

  void _redirectToDashboard(Widget dashboardScreen) {
    // Redirect to the specified dashboard screen
    firebaseUser.value != null ? Get.offAll(() => dashboardScreen) : Get.to(() => const WelcomeScreen());
  }


  Future<String?> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch (e) {
      final ex = LogInWithEmailPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      const ex = LogInWithEmailPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<void> logout() async => await _auth.signOut();
}
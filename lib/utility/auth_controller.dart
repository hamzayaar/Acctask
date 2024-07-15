import 'package:acctask/screen/home_screen.dart';
import 'package:acctask/screen/signin_screen.dart';
import 'package:acctask/widget/mysnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);
  RxBool isLoading = true.obs; 

  @override
  void onReady() {
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
    super.onReady();
  }
  void _setInitialLoadingState(User? user) {
    isLoading.value = false; 
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => SignInPage());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  void signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      showCustomSnackbar('Sign Up Error', getErrorMessage(e));
    } catch (e) {
      showCustomSnackbar(
          'Error', 'An unexpected error occurred. Please try again later.');
    }
  }

  void signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      showCustomSnackbar('Sign I Error', getErrorMessage(e));
    } catch (e) {
      showCustomSnackbar(
          'Error', 'An unexpected error occurred. Please try again later.');
    }
  }

  void signOut() async {
    await _auth.signOut();
  }
}

// GeeksForGeeks error case !
String getErrorMessage(FirebaseAuthException e) {
  switch (e.code) {
    case 'email-already-in-use':
      return 'This email is already in use. Please use a different email.';
    case 'invalid-email':
      return 'The email address is invalid. Please enter a valid email.';
    case 'operation-not-allowed':
      return 'Operation not allowed. Please contact support.';
    case 'weak-password':
      return 'The password is too weak. Please use a stronger password.';
    case 'user-not-found':
      return 'No user found with this email. Please check and try again.';
    case 'wrong-password':
      return 'Incorrect password. Please try again.';
    default:
      return 'An unexpected error occurred. Please try again later.';
  }
}

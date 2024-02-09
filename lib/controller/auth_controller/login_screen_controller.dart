import 'package:automated_bone_marrow_cell_classification_system/view/home_screen/home_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../view/otp_screen.dart';

class LoginScreenController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Rx<User?> user = Rx<User?>(null);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  Future<void> signInWithEmailAndPassword() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    isLoading.value = true;
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        clearFields();

        Get.to(() => HomeMainScreen());
      } on FirebaseAuthException catch (e) {
        passwordController.clear();

        Get.snackbar(
          'Error',
          e.message ?? 'Login failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar(
        'Error',
        'Please enter both email and password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        update(); // Prints after 1 second.
      });
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await _auth.signInWithCredential(credential);
      Get.to(() => HomeMainScreen());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong please try again later',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
    update();
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  //Testing with phone number

  Future<UserCredential?> signInWithPhoneNumber(
      String phoneNumber, String otp) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId:
            phoneNumber, // Assuming you already have the verificationId
        smsCode: otp,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('Error while signing in with phone number OTP: $e');
      return null;
    }
  }

  // Method to send OTP to the user's phone number
  Future<void> sendOtp() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: emailController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', e.message!.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          Get.to(() => const OtpScreen(), arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Get.snackbar('Code auto-retrieval timeout:', ' $verificationId');
        },
      );
    } catch (e) {
      Get.snackbar('Error', ' $e');
    }
  }

  // Method to sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Method to check if the user is signed in
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}

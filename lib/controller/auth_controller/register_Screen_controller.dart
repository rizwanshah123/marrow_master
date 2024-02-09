import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// RegisterScreenController
class RegisterScreenController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode fullNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;
  RxBool isLoading = false.obs; // Added loading state

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  Future<void> register() async {
    isLoading.value = true;
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar('Error', 'Invalid email format',
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading.value = false;
      update();
      return;
    }

    if (fullNameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      Get.snackbar('Error', 'All fields are required',
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading.value = false;
      update();
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      Get.snackbar('Error', 'Passwords do not match',
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading.value = false;
      update();
      return;
    }

    try {
      // Set loading state to true

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await saveUserDetails(userCredential.user!.uid);

      fullNameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      Get.snackbar('Success', 'Registration successful!',
          backgroundColor: Colors.green, colorText: Colors.white);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Registration failed.',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false; // Set loading state back to false
    }
  }

  Future<void> saveUserDetails(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': fullNameController.text.trim(),
      'email': emailController.text.trim(),
    });
  }
}

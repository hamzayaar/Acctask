import 'package:acctask/utility/auth_controller.dart';
import 'package:acctask/widget/mysnackbar.dart';
import 'package:acctask/widget/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _obscureText = true;
  bool _confirmObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SizedBox(
                    width: Get.height * 0.2,
                    child: Image.asset('image/applogo.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "ACC Social Media App",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              CustomTextField(controller: emailController, labelText: 'Email'),
              CustomTextField(
                controller: passwordController,
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                obscureText: _obscureText,
                labelText: 'Password',
              ),
              CustomTextField(
                controller: confirmPasswordController,
                suffixIcon: IconButton(
                  icon: Icon(_confirmObscureText
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _confirmObscureText = !_confirmObscureText;
                    });
                  },
                ),
                obscureText: _confirmObscureText,
                labelText: 'Confirm Password',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _handleSignUp();
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignUp() {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      showCustomSnackbar('Error', 'Passwords do not match.');
      return;
    }

    AuthController.instance.signUp(email, password);
  }
}

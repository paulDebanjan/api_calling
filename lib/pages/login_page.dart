import 'package:api_calling/components/external_login_button_apple.dart';
import 'package:api_calling/components/external_login_button_google.dart';
import 'package:api_calling/components/my_button.dart';
import 'package:api_calling/components/my_stack.dart';
import 'package:api_calling/components/my_textfield.dart';
import 'package:api_calling/api_work.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // sign user in method

    // text editing controller
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // login text
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 50),

                  // username text + field
                  MyTextfield(
                    fieldName: 'Username',
                    controller: usernameController,
                    hintText: 'Enter your Username',
                    obscureText: false,
                  ),

                  SizedBox(height: 22),

                  // password text + field
                  MyTextfield(
                    fieldName: 'Password',
                    controller: passwordController,
                    hintText: '••••••••••••••',
                    obscureText: true,
                  ),

                  SizedBox(height: 30),

                  // login button
                  MyButton(
                    onTap: () {
                      login(
                        usernameController.text,
                        passwordController.text,
                        context,
                      );
                    },
                  ),
                  SizedBox(height: 30),

                  // or stack
                  MyStack(),
                  SizedBox(height: 30),
                  // google login button
                  ExternalLoginButtonGoogle(
                    onTap: () {},
                    buttonName: 'Google',
                    imagePath: 'lib/assets/google.png',
                  ),

                  SizedBox(height: 15),
                  // apple login button
                  ExternalLoginButtonApple(
                    onTap: () {},
                    buttonName: 'Apple',
                    image: Image.asset(
                      'lib/assets/apple.png',
                      color: Colors.white,
                      width: 15,
                    ),
                  ),

                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text('Register', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

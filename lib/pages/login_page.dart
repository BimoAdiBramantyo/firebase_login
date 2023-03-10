import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/components/my_button.dart';
import 'package:firebase_login/components/square_tile.dart';
import 'package:flutter/material.dart';

import '../components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign user in method
  void SignUserIn() async{

    // show loading circle
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
        wrongEmailMessage();

      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        // show erroe to user
        wrongPasswordMessage();
      }
    }
  }

  // Wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect'),
        );
      },
    );
  }

  // Wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Password'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

          // logo
          Icon(
            Icons.lock,
            size: 100,
          ),

          const SizedBox(height: 50),

          // welcome back, you've been missed
          Text(
            'Welcome back you\'ve been missed!',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 25),

          // email textfield
          MyTextField(
            controller: emailController,
            hintText: 'Email',
            obscureText: false,
          ),

          const SizedBox(height: 25),

          // password textfield
          MyTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
          ),

          const SizedBox(height: 10),

          // forgot password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // sign in button
          MyButton(
            onTap: SignUserIn,
          ),

          const SizedBox(height: 50),

          // or continue with
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Or continue with',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
                Expanded(
                  child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),

          // google + apple sign in buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              // google button
              SquareTile(imagePath: 'lib/images/google.png'),

              SizedBox(width: 25),

              // apple button
              SquareTile(imagePath: 'lib/images/apple.png'),
            ],
          ),

          const SizedBox(height: 50),

          // not a member? register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Not a member?',
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(width: 4),
              const Text(
                'Register Now',
                style: TextStyle(
                  color: Colors.blue, 
                  fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:food_app/services/auth/auth_service.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void register() async {
    final authService = AuthService();
    final dialogContext = context;
    if (passwordController.text == confirmPasswordController.text) {
      try {
        await authService.register(
            emailController.text, 
            passwordController.text
        );
      } catch (error) {
        if (dialogContext.mounted) {
          await showErrorDialog(dialogContext, error);
        }
      }
    } else {
      showDialog(
          context: context,
          builder:
              (context) => const AlertDialog(
              title: Text("Passwords don't match.")
          )
      );
    }
  }

  Future<void> showErrorDialog(BuildContext context, dynamic error) async {
    if (!context.mounted) return; // Ensures context is still valid
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(error.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_open_rounded,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            const SizedBox(height: 25),

            Text(
              "Let's create an account",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary
              ),
            ),

            const SizedBox(height: 25),

            MyTextfield(
                controller: emailController,
                hintText: "Enter email",
                obscureText: false
            ),

            const SizedBox(height: 10),

            MyTextfield(
                controller: passwordController,
                hintText: "Enter password",
                obscureText: true
            ),

            const SizedBox(height: 10),

            MyTextfield(
                controller: confirmPasswordController,
                hintText: "Enter again password",
                obscureText: true
            ),

            const SizedBox(height: 10),

            MyButton(
              text: "Sign Up",
              onTap: register
            ),

            const SizedBox(height: 25),

            GestureDetector(
              onTap: widget.onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Login now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

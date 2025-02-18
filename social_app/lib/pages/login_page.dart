import 'package:flutter/material.dart';
import 'package:social_app/components/default_textfield.dart';
import 'package:social_app/utils/context_theme_ext.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: mainContent,
    );
  }

  Widget get mainContent => SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Center(
        child: Column(children: contentChildren),
      ),
    ),
  );

  List<Widget> get contentChildren => [
    spacer,
    lockIcon,
    spacer,
    welcomeText,
    spacer,
    emailField,
    createCustomSpacer(10),
    passwordField
  ];

  Widget get spacer => createCustomSpacer();

  Widget createCustomSpacer([double height = 25]) {
    return SizedBox(height: height);
  }

  Widget get lockIcon => Icon(
    Icons.lock_open_rounded,
    size: 72,
    color: context.colorScheme.primary,
  );

  Widget get welcomeText => Text(
    "Welcome back, you've been missed",
    style: defaultTextStyle,
  );

  TextStyle get defaultTextStyle => TextStyle(
    color: context.colorScheme.primary,
    fontSize: 16
  );

  DefaultTextField get emailField => DefaultTextField(
    controller: emailController,
    hintText: "Enter Email",
    obscureText: false
  );

  DefaultTextField get passwordField => DefaultTextField(
    controller: passwordController,
    hintText: "Enter Password",
    obscureText: true
  );
}

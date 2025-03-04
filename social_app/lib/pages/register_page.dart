import 'package:flutter/material.dart';
import 'package:social_app/utils/context_theme_ext.dart';

import '../components/default_login_circle.dart';
import '../components/default_textfield.dart';
import '../components/primary_button.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTapLoginNow;

  const RegisterPage({
    super.key,
    required this.onTapLoginNow
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final _auth = AuthService();

  void handleRegisterAction() async {
    if (!passwordsMatch()) {
      displayAlertMessage("Passwords do not match.");
      return;
    }

    showLoadingCircle(context);
    attemptRegister();
  }

  bool passwordsMatch() {
    return passwordController.text == confirmPasswordController.text;
  }

  void attemptRegister() async {
    try {
      await _auth.registerUser(
          emailController.text,
          passwordController.text
      );
      if (mounted) hideLoadingCircle(context);
    } catch(e) {
      handleError(e.toString());
    }
  }

  void handleError(String errorMessage) {
    if (!mounted) return;
    hideLoadingCircle(context);
    displayAlertMessage(errorMessage);
  }

  void displayAlertMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(message),
        )
    );
  }

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
    mediumSpacer,
    lockIcon,
    mediumSpacer,
    welcomeText,
    mediumSpacer,
    nameField,
    smallSpacer,
    emailField,
    smallSpacer,
    passwordField,
    smallSpacer,
    confirmPasswordField,
    mediumSpacer,
    primaryButton,
    largeSpacer,
    loginRowView
  ];

  Widget get smallSpacer => createCustomSpacer(10);
  Widget get mediumSpacer => createCustomSpacer();
  Widget get largeSpacer => createCustomSpacer(50);

  Widget createCustomSpacer([double height = 25]) {
    return SizedBox(height: height);
  }

  Widget get lockIcon => Icon(
    Icons.lock_open_rounded,
    size: 72,
    color: context.colorScheme.primary,
  );

  Widget get welcomeText => Text(
    "Let's create an account for you",
    style: defaultTextStyle,
  );

  TextStyle get defaultTextStyle => TextStyle(
      color: context.colorScheme.primary,
      fontSize: 16
  );

  DefaultTextField get nameField => DefaultTextField(
      controller: nameController,
      hintText: "Enter Name",
      obscureText: false
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

  DefaultTextField get confirmPasswordField => DefaultTextField(
      controller: confirmPasswordController,
      hintText: "Re-enter Password",
      obscureText: true
  );

  PrimaryButton get primaryButton => PrimaryButton(
      text: "Register",
      onTap: handleRegisterAction
  );

  Row get loginRowView => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      alreadyMemberText,
      const SizedBox(width: 5),
      loginNowTextGesture
    ],
  );

  Text get alreadyMemberText => Text(
    "Already a member?",
    style: TextStyle(
        color: context.colorScheme.primary
    ),
  );

  GestureDetector get loginNowTextGesture => GestureDetector(
      onTap: widget.onTapLoginNow,
      child: Text(
        "Login now",
        style: TextStyle(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.bold
        ),
      )
  );
}

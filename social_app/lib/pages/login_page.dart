import 'package:flutter/material.dart';
import 'package:social_app/components/default_login_circle.dart';
import 'package:social_app/components/default_textfield.dart';
import 'package:social_app/components/primary_button.dart';
import 'package:social_app/services/auth/auth_service.dart';
import 'package:social_app/utils/context_theme_ext.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTapRegisterNow;

  const LoginPage({
    super.key,
    required this.onTapRegisterNow
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = AuthService();

  void handleLoginAction() async {
    showLoadingCircle(context);
    attemptLogin();
  }

  void attemptLogin() async {
    try {
      await _auth.loginUser(
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
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(errorMessage),
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
    emailField,
    smallSpacer,
    passwordField,
    smallSpacer,
    forgotPassword,
    mediumSpacer,
    primaryButton,
    largeSpacer,
    registerRowView
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
    "Welcome back, you've been missed!",
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

  Align get forgotPassword => Align(
    alignment: Alignment.centerRight,
    child: forgotPasswordText,
  );

  Text get forgotPasswordText => Text(
    "Forgot Password?",
    style: TextStyle(
      color: context.colorScheme.primary,
      fontWeight: FontWeight.bold
    ),
  );

  PrimaryButton get primaryButton => PrimaryButton(
      text: "Login",
      onTap: handleLoginAction
  );

  Row get registerRowView => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      notMemberText,
      const SizedBox(width: 5),
      registerNowTextGesture
    ],
  );

  GestureDetector get registerNowTextGesture => GestureDetector(
    onTap: widget.onTapRegisterNow,
    child: Text(
      "Register now",
      style: TextStyle(
          color: context.colorScheme.primary,
          fontWeight: FontWeight.bold
      ),
    )
  );

  Text get notMemberText => Text(
    "Not a member?",
    style: TextStyle(
        color: context.colorScheme.primary
    ),
  );
}

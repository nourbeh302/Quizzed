import 'package:flutter/material.dart';
import 'package:quizzed/constant.dart';
import 'package:quizzed/models/auth.dart';
import 'package:quizzed/validators/email_validator.dart';
import 'package:quizzed/validators/password_validator.dart';
// import 'package:quizzed/widgets/app_bar.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Define input controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailValidator = EmailValidator();
  final _passwordValidator = PasswordValidator();

  Future<void> logIn() async {
    await Auth().logIn(
        email: _emailController.text, password: _passwordController.text);

    navigateToHomeScreen();
  }

  void navigateToHomeScreen() {
    Navigator.pushNamed(context, '/');
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: Text(
          "Login",
          style:
              TextStyle(fontFamily: baseFontFamily, fontSize: appBarFontSize),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Container(
          margin: const EdgeInsets.fromLTRB(0, 48, 0, 0),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Fill the field";
                            }
                            if (!_emailValidator.isEmailValid(value)) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          style: TextStyle(
                              fontFamily: baseFontFamily,
                              fontSize: inputFontSize),
                          decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  fontFamily: baseFontFamily,
                                  fontSize: inputFontSize),
                              focusColor: primaryColor,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: primaryColor,
                              ))),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Fill the field";
                            }
                            if (!_passwordValidator.isPasswordValid(value)) {
                              return "Passwords should be at least ${_passwordValidator.minCharacters} characters";
                            }
                            return null;
                          },
                          style: TextStyle(
                              fontFamily: baseFontFamily,
                              fontSize: inputFontSize),
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  fontFamily: baseFontFamily,
                                  fontSize: inputFontSize),
                              focusColor: primaryColor,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: primaryColor,
                              ))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/register'),
                    child: Text(
                      'A newbie here? Create new account',
                      style: TextStyle(
                          fontFamily: baseFontFamily,
                          fontSize: linkFontSize,
                          color: primaryColor),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        logIn();
                      }
                    },
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size.fromHeight(32)),
                        shape: const MaterialStatePropertyAll(StadiumBorder()),
                        padding: MaterialStateProperty.all(buttonPadding),
                        elevation: MaterialStateProperty.all(0)),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: buttonFontSize,
                          fontFamily: baseFontFamily,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(32),
                      padding: buttonPadding,
                      shape: const StadiumBorder(),
                      side: BorderSide(width: 1, color: primaryColor),
                    ),
                    onPressed: () => logIn(),
                    child: Text(
                      'Sign in as Professor',
                      style: TextStyle(
                          fontFamily: baseFontFamily,
                          color: primaryColor,
                          fontSize: buttonFontSize),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quizzed/constant.dart';
// import 'package:quizzed/widgets/app_bar.dart';

final _formKey = GlobalKey<FormState>();

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  // Define input controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: Text(
          "Register",
          style: TextStyle(fontFamily: baseFontFamily, fontSize: appBarFontSize),
        ),
        backgroundColor: primaryColor,
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
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Fill the field";
                            }
                            return null;
                          },
                          style: TextStyle(
                              fontFamily: baseFontFamily, fontSize: inputFontSize),
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
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Fill the field";
                            }
                            return null;
                          },
                          style: TextStyle(
                              fontFamily: baseFontFamily, fontSize: inputFontSize),
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
                    onTap: () => Navigator.pushNamed(context, '/login'),
                    child: Text(
                      'Already have account? Sign in',
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
                    onPressed: () => print('email: ${emailController.text}\npassword: ${passwordController.text}'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      minimumSize:
                          MaterialStateProperty.all(const Size.fromHeight(32)),
                      shape: const MaterialStatePropertyAll(StadiumBorder()),
                      padding: MaterialStateProperty.all(buttonPadding),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: buttonFontSize,
                          fontFamily: baseFontFamily,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

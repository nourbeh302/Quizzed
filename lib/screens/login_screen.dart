import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const AppBarWidget(),
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
                  const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Fill the field";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 18,
                              fontFamily: "DMSans",
                            ),
                            labelText: "Enter your email",
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Fill the field";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontFamily: "DMSans",
                              ),
                              labelText: "Enter your password"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                ],
              ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //       minimumSize: const Size.fromHeight(32),
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 32, vertical: 12),
              //       backgroundColor: const Color.fromARGB(255, 255, 187, 78),
              //       shape: const StadiumBorder()),
              //   onPressed: null,
              //   child: const Text(
              //     'Login',
              //     style: TextStyle(
              //         fontFamily: "DMSans", color: Colors.black, fontSize: 18),
              //   ),
              ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 244, 197, 54)),
                  minimumSize:
                      MaterialStateProperty.all(const Size.fromHeight(32)),
                  shape: const MaterialStatePropertyAll(StadiumBorder()),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 18, fontFamily: "DMSans", color: Colors.black),
                ),
              ),
            ],
          )),
    );
  }
}

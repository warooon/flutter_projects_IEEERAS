// ignore_for_file: avoid_unnecessary_containers, must_be_immutable, use_build_context_synchronously

import "dart:async";

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:vshare/components/button_component.dart";
import "package:vshare/components/snackbar_component.dart";
import "package:vshare/components/textfield_component.dart";
import "package:vshare/resources/Colors.dart";
import "package:vshare/services/auth_service.dart";

class LoginPage extends StatefulWidget {
  void Function()? togglePage;
  LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  double angle = 0.0;
  Timer _timer = Timer(Duration.zero, () {}); // Timer variable

  void startRotation() {
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        angle += 0.01;
      });
    });
  }

  void stopRotation() {
    _timer.cancel();
  }

  @override
  void dispose() {
    stopRotation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGreenColor,
        body: Container(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Transform.rotate(
                    angle: angle,
                    child: const Image(
                        image: AssetImage("assets/images/cell.png")),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 30),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Don't have an Account?  ",
                        style: TextStyle(
                            color: greyColor,
                            fontFamily: "PoppinsRegular",
                            fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: widget.togglePage,
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "PoppinsSemiBold",
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -screenSize.height * 0.32,
              child: SingleChildScrollView(
                child: Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  color: primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldComponent(
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        hintText: "email",
                        icon: const Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                        textEditingController: emailController,
                      ),
                      TextFieldComponent(
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        hintText: "password",
                        icon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                        textEditingController: passwordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Center(
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(
                                color: greyColor,
                                fontFamily: "PoppinsRegular",
                                fontSize: 13),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.028,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              if (emailController.text.trim().isEmpty ||
                                  passwordController.text.trim().isEmpty) {
                                SnackBarComponent.showSnackBar(
                                    context,
                                    "warning",
                                    "Fill both email and password fields.");
                              } else if (!(emailController.text
                                  .trim()
                                  .split("@")[1]
                                  .endsWith("vitstudent.ac.in"))) {
                                SnackBarComponent.showSnackBar(
                                    context,
                                    "warning",
                                    "Please use a VIT University email ID.");
                              } else {
                                startRotation();
                                await Provider.of<AuthService>(context,
                                        listen: false)
                                    .login(emailController.text,
                                        passwordController.text);
                              }
                            } catch (e) {
                              SnackBarComponent.showSnackBar(context, "error",
                                  "Invalid email or password!");
                            }
                          },
                          child: const ButtonComponent(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

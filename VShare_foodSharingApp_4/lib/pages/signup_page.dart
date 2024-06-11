// ignore_for_file: avoid_unnecessary_containers, must_be_immutable, use_build_context_synchronously

import "dart:async";

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:vshare/components/snackbar_component.dart";
import "package:vshare/components/textfield_component.dart";
import "package:vshare/resources/Colors.dart";
import "package:vshare/services/auth_service.dart";

class SignupPage extends StatefulWidget {
  void Function()? togglePage;
  SignupPage({super.key, required this.togglePage});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phonenumberController = TextEditingController();
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
                    "Create an",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 30),
                  ),
                  const Text(
                    "Account",
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
                        "Already a Member?  ",
                        style: TextStyle(
                            color: greyColor,
                            fontFamily: "PoppinsRegular",
                            fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: widget.togglePage,
                        child: const Text(
                          "Log In",
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
              bottom: -screenSize.height * 0.4,
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
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        hintText: "username",
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        textEditingController: usernameController,
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
                        keyboardType: TextInputType.number,
                        hintText: "phone number",
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        textEditingController: phonenumberController,
                      ),
                      TextFieldComponent(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        hintText: "password",
                        icon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                        textEditingController: passwordController,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "I have read and agree to Terms &\nConditions of the company",
                              style: TextStyle(
                                  color: greyColor,
                                  fontFamily: "PoppinsRegular",
                                  fontSize: 13),
                            ),
                            FloatingActionButton(
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () async {
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
                                    setState(() {
                                      startRotation();
                                    });
                                    await Provider.of<AuthService>(context,
                                            listen: false)
                                        .signup(
                                            usernameController.text,
                                            emailController.text,
                                            phonenumberController.text,
                                            passwordController.text);
                                  }
                                } catch (e) {
                                  final exception = e.toString().split(" ")[1];

                                  if (exception == "weak-password") {
                                    SnackBarComponent.showSnackBar(
                                        context,
                                        "warning",
                                        "Please use a stronger password.");
                                  } else if (exception == "invalid-email") {
                                    SnackBarComponent.showSnackBar(
                                        context,
                                        "warning",
                                        "Please enter a valid email address.");
                                  } else if (exception ==
                                      "email-already-in-use") {
                                    SnackBarComponent.showSnackBar(context,
                                        "warning", "Email is already in use.");
                                  } else {
                                    SnackBarComponent.showSnackBar(
                                        context,
                                        "error",
                                        "An unexpected error occurred.");
                                  }
                                } finally {}
                              },
                              backgroundColor: yellowColor,
                              child: const Icon(
                                Icons.arrow_right,
                                size: 40,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
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

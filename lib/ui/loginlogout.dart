import 'package:ecommerceapp/prefernce/preference.dart';
import 'package:ecommerceapp/ui/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerceapp/ui/homepage.dart'; // Import PreferenceService

class LoginLogout extends StatelessWidget {
  const LoginLogout({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final email = emailController.text;
                      final password = passwordController.text;
                      final savedPassword =
                          await PreferenceService.getUserPassword(email);

                      if (savedPassword != null && savedPassword == password) {
                        Get.to(() => Homepage());
                      } else {
                        Get.snackbar(
                          'Error',
                          'Invalid email or password',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => Register());
                    },
                    child: Text('Register'),
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

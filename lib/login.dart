import 'package:flutter/material.dart';
import 'package:flutter_application_1/bottom.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_text_field.dart';
import 'package:flutter_application_1/home.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username != 'admin' || password != 'admin') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Username atau Password Salah"),
        ),
      );
      return;
    }
    final box = GetStorage();
    box.write('username', usernameController.text);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (builder) => Bottom()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Container(
  padding: EdgeInsets.symmetric(horizontal: 16),
  width: double.infinity,
  color: Colors.black, // Set background color to black for dark theme
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(
        height: 40,
      ),
      Text(
        "Selamat Datang",
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Set text color to white
        ),
      ),
      Text(
        "Silahkan Login",
        style: TextStyle(
          fontSize: 24,
          color: Colors.grey,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      AppTextField(
        label: "Username",
        controller: usernameController,
        textColor: Colors.white, // Set text color to white
        labelColor: Colors.grey, // Set label color to grey
        borderColor: Colors.grey, // Set border color to grey
      ),
      SizedBox(
        height: 10,
      ),
      AppTextField(
        label: "Password",
        controller: passwordController,
        textColor: Colors.white, // Set text color to white
        labelColor: Colors.grey, // Set label color to grey
        borderColor: Colors.grey, // Set border color to grey
        obscureText: true, // Hide password text
      ),
      const SizedBox(
        height: 20,
      ),
      AppButton(
        text: "Login",
        color: Colors.blue,
        onPressed: () {
          login();
        },
        textColor: Colors.white, // Set text color to white
      ),
    ],
  ),
),

    );
  }
}

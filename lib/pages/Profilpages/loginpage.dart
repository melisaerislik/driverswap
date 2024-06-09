import '../../../bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/alert_error_message.dart';
import '../../Service/firebase_auth_service.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  FireBaseAuthServices authServices = FireBaseAuthServices();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void SignIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await authServices.signInEmailAndPassword(email, password);
    if (user == null) {
      // ignore: use_build_context_synchronously
      showErrorDialog(context, 'Kullanıcı adı veya şifre hatalıdır.');
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditBottomNavigationBar()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //pixel klavye açıldığında boyut değiştirmemesi için

      body: Stack(
        children: [
          Container(
            
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffFED93E), Color(0xff4CAF50)],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 50.0, left: 30),
              child: Text(
                'DRİVER\nSWAP!',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.check, color: Colors.grey),
                        label: Text(
                          'Gmail',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4CAF50),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
                        label: Text(
                          'Parola',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4CAF50),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Parolanı mı Unuttun?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color(0xff4CAF50),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                    InkWell(
                      onTap: () {
                        SignIn();
                      },
                      child: Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffFED93E), // Sarı renk
                              Color(0xff4CAF50),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Giriş',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 150),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/user_auth/presentation/pages/Register_page.dart';
import 'package:flutter/material.dart';

import '../../../../global/common/toast.dart';
import '../../firebase_auth_implementation/firebase_auth_services.dart';
import '../widgets/form_container_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isSigning = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 57, 116, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                  width: 103,
                  height: 81,
                  decoration: const BoxDecoration(
                    boxShadow : [BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.07),
                        offset: Offset(0,4),
                        blurRadius: 17
                    )],
                    image : DecorationImage(
                        image: AssetImage('assets/images/whiteDove.png'),
                        fit: BoxFit.fitWidth
                    ),
                  )
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "WHITE DOVE",
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Đăng Nhập",
                style: TextStyle(color: Color.fromRGBO(255, 236, 208, 30), fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              FormContainerWidget(
                controller: _emailController,
                isPasswordField: false,
                hintText: "Email",

              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Mật khẩu",
                isPasswordField: true,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap:  (){
                  _signIn();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(55, 35, 41, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: isSigning ? const CircularProgressIndicator(color: Colors.white,):const Text(
                        "Đăng nhập",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Chưa có tài khoản?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                                (route) => false);
                      },
                      child: const Text(
                        "Đăng ký",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 236, 208, 30), fontWeight: FontWeight.bold,),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

void _signIn() async {

  setState(() {
    isSigning = true;
  });

  String email = _emailController.text;
  String password = _passwordController.text;

  User? user = await _auth.signInWithEmailAndPassword(email, password);

  setState(() {
    isSigning = false;
  });
  if (user != null) {
    Navigator.pushNamed(context, "/home");
    showToast(message: "Đăng nhập thành công!");
  } else {
    showToast(message: "Some error happend");
  }
}
}
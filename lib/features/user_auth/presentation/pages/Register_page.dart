import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter/material.dart';

import '../../../../global/common/toast.dart';
import '../widgets/form_container_widget.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(255, 57, 116, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Đăng Ký",
                style: TextStyle(color: Color.fromRGBO(255, 236, 208, 30), fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              FormContainerWidget(
                controller: _usernameController,
                labelText: "Tên",
                hintText: "Nhập tên vào đây",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _emailController,
                isPasswordField: false,
                labelText: "Email",
                hintText: "Nhập email vào đây",
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _phoneController,
                isPasswordField: false,
                labelText: "Số điện thoại",
                hintText: "Nhập số điê thoại vào đây",
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _addressController,
                isPasswordField: false,
                labelText: "Địa chỉ",
                hintText: "Nhập địa chỉ vào đây",
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                labelText: "Mật khẩu",
                hintText: "Nhập mật khẩu",
                isPasswordField: true,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap:  (){
                  _signUp();
                  //showToast(message: "Đăng ký tài khoản thành công");
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(55, 35, 41, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: isSigningUp ? const CircularProgressIndicator(color: Colors.white,):const Text(
                        "Đăng ký",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Đã có tài khoản?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                                (route) => false);
                      },
                      child: const Text(
                        "Đăng nhập",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 236, 208, 30), fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {

    setState(() {
      isSigningUp = true;
    });

    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String phone = _phoneController.text;
    String address = _addressController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    // setState(() {
    //   isSigningUp = false;
    // });
    if (user != null) {
      await _auth.saveUserDetails(
        uid: user.uid,
        fullName: username,
        email: email,
        phoneNumber: phone,
        address: address,
      );
      Navigator.pushNamed(context, "/login");
      showToast(message: "Đăng ký tài khoản thành công");
    } else {
      showToast(message: "Đã có lỗi xảy ra!");
    }
  }
}
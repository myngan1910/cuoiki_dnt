import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../global/common/toast.dart';
import '../widgets/menu_widget.dart';
import '../widgets/slideWidget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Timer? _timer;

  void startTimer() {
    _timer = Timer(const Duration(seconds: 2), callSOS);
  }

  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> callSOS() async {
    const url = 'tel://111'; // 111 là số khẩn cấp
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast(message: "Không thể thực hiện cuộc gọi");
    }
  }

  Widget _buildSOSButton() {
    return GestureDetector(
      onLongPressStart: (details) => startTimer(),
      onLongPressEnd: (details) => cancelTimer(),
      child: Container(
        width: 190,
        height: 190,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(254, 188, 183, 1),
          borderRadius: BorderRadius.all(Radius.circular(190)),
        ),
        child: Center(
          child: Container(
            width: 152,
            height: 152,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 57, 116, 1),
                  Color.fromRGBO(255, 236, 208, 1),
                  Color.fromRGBO(255, 57, 116, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.all(Radius.circular(152)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 30),
                Text(
                  'SOS',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 57, 116, 1),
                    fontFamily: 'Tinos',
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 0),
                Text(
                  'Nhấn và giữ 3s \nđể gọi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontFamily: 'Comfortaa',
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text(
            "User",
            style: TextStyle(
              color: Color.fromRGBO(255, 57, 116, 1),
              fontFamily: 'Days One',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          );
        }

        final doc = snapshot.data!.docs.first;
        final name = doc['fullName']?.toString() ?? 'N/A';

        return Text(
          "Chào, $name!",
          style: const TextStyle(
            color: Color.fromRGBO(255, 57, 116, 1),
            fontFamily: 'Days One',
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 236, 208, 1),
                  Color.fromRGBO(255, 57, 116, 1),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            top: 113,
            left: 100,
            child: _buildSOSButton(),
          ),
          Positioned(
            top: 55,
            left: 79,
            child: const Text(
              'WhiteDove Safe',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 55,
            left: 325,
            child: IconButton(
              icon: const FaIcon(FontAwesomeIcons.signOutAlt, size: 22, color: Colors.white70),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                showToast(message: "Đăng xuất thành công!");
                Navigator.pushNamed(context, "/login");
              },
            ),
          ),
          Positioned(
            top: 329,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 490,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 236, 208, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserName(),
                    const SizedBox(height: 3),
                    const Text(
                      'Bạn thấy hôm nay thế nào?',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Days One',
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(bottom: 120, child: slideWidget()),
          const Positioned(bottom: 0, left: 0, child: MenuWidget()),
        ],
      ),
    );
  }
}

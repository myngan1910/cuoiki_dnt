import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/features/user_auth/presentation/pages/detail_request_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'features/app/splash_screen/splash_screen.dart';
import 'features/user_auth/presentation/pages/Register_page.dart';
import 'features/user_auth/presentation/pages/contact_page2.dart';
import 'features/user_auth/presentation/pages/login_page.dart';
import 'features/user_auth/presentation/pages/main_page.dart';
import 'features/user_auth/presentation/pages/request_page.dart';
import 'features/user_auth/presentation/pages/status_request.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase tùy vào nền tảng
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyB2jKfGAvbqpdY40zL5NHAGT2h60HlwmzU",
        appId: "1:971829953499:web:5ffa4ca83c1ac3cfbe5dfe",
        messagingSenderId: "971829953499",
        projectId: "whitedove-932e5",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(
              child: FirebaseAuth.instance.currentUser == null
                  ? const LoginPage()
                  : MainPage(),
            ),
        '/login': (context) => const LoginPage(),
        '/signUp': (context) => const RegisterPage(),
        '/home': (context) => MainPage(),
        '/contact2': (context) => ContactPage2(),
        '/request': (context) => const RequestPage(),
        '/request-detail': (context) => const DetailRequestPage(),
        '/request-status': (context) => const StatusRequestPage(),
      },
    );
  }
}

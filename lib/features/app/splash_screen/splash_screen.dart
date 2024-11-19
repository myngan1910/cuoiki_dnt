import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 5),(){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child!), (route) => false);
    }
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 57, 116, 1),
      body: Center(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                  width: 157,
                  height: 123,
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
                height: 25,
              ),
              const Text(
                "WHITE DOVE",
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 1,
              ),
              const Text(
                "Mở ra cánh cửa hy vọng",
                style: TextStyle(color: Color.fromRGBO(255, 236, 208, 30), fontSize: 19, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
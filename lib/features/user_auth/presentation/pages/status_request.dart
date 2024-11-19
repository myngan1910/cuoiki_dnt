import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../global/common/toast.dart';

class StatusRequestPage extends StatefulWidget {
  const StatusRequestPage({super.key});

  @override
  State<StatusRequestPage> createState() => _StatusRequestPageState();
}

class _StatusRequestPageState extends State<StatusRequestPage> {
  //final FirebaseAuthServices _auth = FirebaseAuthServices();

  final _nameOfContactController = TextEditingController();
  final _phoneNumberOfContactController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    final status = arguments?['status'] as String?;
    final name = arguments?['name'] as String?;
    final age = arguments?['age'] as String?;
    final phone = arguments?['phone'] as String?;
    final address = arguments?['address'] as String?;
    final times = arguments?['times'] as String?;
    final detail = arguments?['detail'] as String?;

    final statusText;
    if(status == '0') {
      statusText = "Đã gửi";
    } else if (status == '1'){
      statusText = "Đã xác nhận";
    } else if (status == '2'){
      statusText = "Đã lên kế hoạch hổ trợ";
    } else if (status == '3'){
      statusText = "Đang trên đường đến";
    } else {
      statusText = "Đã hổ trợ";
    }


    // Set màu sắc mặc định
    Color backgroundColor1 = Color.fromRGBO(255, 57, 116, 1);
    Color iconColor1 = Color.fromRGBO(255, 236, 208, 1);
    Color backgroundColor2 = Color.fromRGBO(255, 57, 116, 1);
    Color iconColor2 = Color.fromRGBO(255, 236, 208, 1);
    Color backgroundColor3 = Color.fromRGBO(255, 57, 116, 1);
    Color iconColor3 = Color.fromRGBO(255, 236, 208, 1);

    if (status == '0') {
      // Nếu status là 1: Màu xám cho tất cả các CircleAvatar và đường kẻ
      backgroundColor1 = Colors.grey;
      iconColor1 = Color.fromRGBO(255, 236, 208, 1);
      backgroundColor2 = Colors.grey;
      iconColor2 = Color.fromRGBO(255, 236, 208, 1);
      backgroundColor3 = Colors.grey;
      iconColor3 = Color.fromRGBO(255, 236, 208, 1);
    } else if (status == '1') {
      backgroundColor2 = Colors.grey;
      iconColor2 = Color.fromRGBO(255, 236, 208, 1);
      backgroundColor3 = Colors.grey;
      iconColor3 = Color.fromRGBO(255, 236, 208, 1);
    } else if (status == '2') {
      backgroundColor3 = Colors.grey;
      iconColor3 = Color.fromRGBO(255, 236, 208, 1);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false, //cho phép đè bàn phím lên giao diện

      appBar: AppBar(
        automaticallyImplyLeading:
            true, // tự động thêm nút back khi giao diện hiện tại không phải root
        title: const Text(
          "Tình trạng yêu cầu hổ trợ",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 57, 116, 1),
        //elevation: 10,  // Thêm độ nổi cho AppBar
      ),
      body: Center(
          child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromRGBO(255, 57, 116, 1),
                Color.fromRGBO(255, 236, 208, 1)
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 57,
              ),
              //STATUS REPORT
              Container(
                child: Stack(
                  children: [
                    // CustomPaint để vẽ đường thẳng
                    CustomPaint(
                      size: Size(double.infinity, 100),
                      painter: LinePainter(), // Trình vẽ đường thẳng
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 31,
                              backgroundColor:
                                  backgroundColor1,
                              child: FaIcon(
                                FontAwesomeIcons.check,
                                size: 22,
                                color: iconColor1,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Yêu cầu \ncủa bạn đã \nđược xác nhận",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 31,
                              backgroundColor:
                                  backgroundColor2,
                              child: FaIcon(
                                FontAwesomeIcons.fileContract,
                                size: 22,
                                color: iconColor2,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Lên kế \nhoạch để hổ \ntrợ nạn nhân",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 31,
                              backgroundColor:
                                  backgroundColor3,
                              child: FaIcon(
                                FontAwesomeIcons.carAlt,
                                size: 22,
                                color: iconColor3,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Chúng tôi \nđang trên đường \nđến hổ trợ",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Chi tiết yêu cầu đã gửi",
                style: TextStyle(
                    color: Color.fromRGBO(255, 57, 116, 1),
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 450,
                  // Chiều cao cố định cho vùng cuộn
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(
                        horizontal: 13, vertical: 13),
                    height: 115,
                    width: 352,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(2, 2),
                            blurRadius: 5)
                      ],
                      color: Color.fromRGBO(255, 236, 208, 1),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tên: $name",
                              style: const TextStyle(
                                  color:
                                  Color.fromRGBO(55, 35, 41, 1),
                                  fontFamily: 'Comfortaa',
                                  fontSize: 20,
                                  letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.15),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Tuổi: $age",
                              style: const TextStyle(
                                  color:
                                  Color.fromRGBO(55, 35, 41, 1),
                                  fontFamily: 'Comfortaa',
                                  fontSize: 17,
                                  letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.15),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Số điện thoại: $phone",
                              style: const TextStyle(
                                  color:
                                  Color.fromRGBO(55, 35, 41, 1),
                                  fontFamily: 'Comfortaa',
                                  fontSize: 17,
                                  letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.15),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Địa chỉ: $address",
                              style: const TextStyle(
                                  color:
                                  Color.fromRGBO(55, 35, 41, 1),
                                  fontFamily: 'Comfortaa',
                                  fontSize: 17,
                                  letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.15),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Thời gian yêu cầu: $times",
                              style: const TextStyle(
                                  color: Color.fromRGBO(
                                      120, 120, 120, 1),
                                  fontFamily: 'Comfortaa',
                                  fontSize: 16,
                                  letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.4375),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Tình trạng: $statusText",
                              style: const TextStyle(
                                  color:
                                  Color.fromRGBO(55, 35, 41, 1),
                                  fontFamily: 'Comfortaa',
                                  fontSize: 17,
                                  letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.15),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Nội dung chi tiết: ",
                              style: const TextStyle(
                                  color:
                                  Color.fromRGBO(55, 35, 41, 1),
                                  fontFamily: 'Comfortaa',
                                  fontSize: 17,
                                  letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.15),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Container(
                              height: 220,
                              width: 320,
                              child: SingleChildScrollView(
                                child: Text(
                                  detail!,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(255, 57, 116, 1),
                                    fontFamily: 'Comfortaa',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    height: 1.4375,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

//đường kẻ nối
class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(255, 236, 208, 1)
      ..strokeWidth = 5;

    final height = size.height / 3; // Đường thẳng ở giữa các CircleAvatar
    final padding =
        70.0; // Khoảng cách giữa các CircleAvatar (cần chỉnh cho đúng khoảng cách thực tế)

    // Vẽ đường giữa các CircleAvatar
    canvas.drawLine(Offset(padding + 0, height),
        Offset(size.width / 1.5 - padding, height), paint);
    canvas.drawLine(Offset(size.width / 4 + padding, height),
        Offset(size.width - padding - 10, height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

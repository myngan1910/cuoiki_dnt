import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../global/common/toast.dart';

class DetailRequestPage extends StatefulWidget {
  const DetailRequestPage({super.key});

  @override
  State<DetailRequestPage> createState() => _DetailRequestPageState();
}

class _DetailRequestPageState extends State<DetailRequestPage> {
  //final FirebaseAuthServices _auth = FirebaseAuthServices();

  final _nameOfContactController = TextEditingController();
  final _phoneNumberOfContactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //cho phép đè bàn phím lên giao diện

      appBar: AppBar(
        automaticallyImplyLeading:
            true, // tự động thêm nút back khi giao diện hiện tại không phải root
        title: const Text(
          "Yêu cầu hổ trợ",
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
                height: 27,
              ),
              const Text(
                "Danh sách các yêu cầu đã gửi đi",
                style: TextStyle(
                    color: Color.fromRGBO(255, 57, 116, 1),
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 530,
                  // Chiều cao cố định cho vùng cuộn
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('support_requests')
                        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(child: Text('Có lỗi xảy ra'));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text("Không có yêu cầu hỗ trợ nào."));
                      }

                      List<Row> trustContactWidgets = [];
                      if (snapshot.hasData) {
                        final trustContacts =
                            snapshot.data?.docs.reversed.toList();
                        for (var trustContact in trustContacts!) {
                          final status =
                              trustContact['status']?.toString() ?? 'N/A';
                          final name =
                              trustContact['name']?.toString() ?? 'N/A';
                          final age =
                              trustContact['age']?.toString() ?? 'N/A';
                          final address =
                              trustContact['address']?.toString() ?? 'N/A';
                          final phone =
                              trustContact['phoneNumber']?.toString() ?? 'N/A';
                          final details =
                              trustContact['details']?.toString() ?? 'N/A';
                          // Chuyển timestamp thành DateTime
                          final timestamp =
                              trustContact['timestamp'] as Timestamp?;
                          final formattedTime = timestamp != null
                              ? DateFormat('dd-MM-yyyy HH:mm:ss')
                                  .format(timestamp.toDate())
                              : 'N/A';

                          final trustContactWidget = Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
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
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/request-status',
                                          arguments: {
                                            'status': status,
                                            'name': name,
                                            'age': age,
                                            'detail': details,
                                            'address': address,
                                            'phone': phone,
                                            'times': formattedTime,
                                          },
                                        );
                                        print("Trạng thái: $status, \nTên: $name,"
                                            " Tuổi: \n$age, Địa chỉ: $address, "
                                            "\nSDT: $phone, "
                                            "Thời gian: \n$formattedTime, Chi  tiết: $details");
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
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
                                            height: 3,
                                          ),
                                          Text(
                                            formattedTime,
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
                                            height: 9,
                                          ),
                                          Text(
                                            details.length >
                                                35 // 40 là giới hạn số ký tự
                                                ? '${details.substring(0, 33) }...'
                                                : details,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 57, 116, 1),
                                                fontFamily: 'Comfortaa',
                                                fontSize: 16,
                                                letterSpacing:
                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                                fontWeight: FontWeight.normal,
                                                height: 1.4375),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 1),
                                            child: IconButton(
                                              onPressed: () {
                                                var conllection =
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'support_requests');
                                                conllection
                                                    .doc(trustContact.id)
                                                    .delete();
                                                showToast(
                                                    message: "Xóa thành công");
                                              },
                                              icon: const FaIcon(
                                                FontAwesomeIcons
                                                    .solidTrashAlt, //
                                                size: 22,
                                                color: Colors.black,
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                          trustContactWidgets.add(trustContactWidget);
                        }
                      } else {
                        const CircularProgressIndicator();
                      }
                      return Expanded(
                          child: ListView(
                        children: trustContactWidgets,
                      ));
                    },
                  )),
                  const SizedBox(
                    height: 20
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
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
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/request");
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons
                                .plus, //
                            size: 22,
                            color: Colors.black,
                          )
                          ),
                      )
                    ],
                  )
            ],
          ),
        ),
      )),
    );
  }
}

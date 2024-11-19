import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../global/common/toast.dart';

class ContactPage2 extends StatefulWidget {

  @override
  State<ContactPage2> createState() => _ContactPage2State();
}

class _ContactPage2State extends State<ContactPage2> {
  //final FirebaseAuthServices _auth = FirebaseAuthServices();

  final _nameOfContactController = TextEditingController();
  final _phoneNumberOfContactController = TextEditingController();


  // Hàm gọi số điện thoại
  void _launchPhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Không thể gọi số này: $phoneNumber';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //cho phép đè bàn phím lên giao diện

      appBar: AppBar(
        automaticallyImplyLeading: true, // tự động thêm nút back khi giao diện hiện tại không phải root
        title: const Text("Liên lạc tin tưởng", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
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
                  height: 20,
                ),
                TextFormField(
                  controller: _nameOfContactController,
                  decoration: const InputDecoration(
                    hintText: 'Nhập tên',
                    hintStyle: TextStyle(color: Color.fromRGBO(255, 57, 116, 1),),
                    contentPadding: EdgeInsets.only(left: 9),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(255, 57, 116, 1), width: 2.0),
                    ),
                  ),
                  style: const TextStyle(color: Color.fromRGBO(255, 57, 116, 1),),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _phoneNumberOfContactController,
                  decoration: const InputDecoration(
                    hintText: 'Nhập số điện thoại',
                    hintStyle: TextStyle(color: Color.fromRGBO(255, 57, 116, 1),),
                    contentPadding: EdgeInsets.only(left: 9),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(255, 57, 116, 1), width: 2.0),
                    ),
                  ),
                  style: const TextStyle(color: Color.fromRGBO(255, 57, 116, 1),),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    try {
                      // Lấy uid của người dùng hiện tại
                      User? currentUser = FirebaseAuth.instance.currentUser;
                      if (currentUser == null) {
                        showToast(message: "Người dùng chưa đăng nhập!");
                        return;
                      }
                      String uid = currentUser.uid;

                      // Truyền dữ liệu vào Firestore, bao gồm cả UID của người dùng
                      CollectionReference collRef = FirebaseFirestore.instance.collection('trust_contact');

                      collRef.add({
                        'userId': uid, // Lưu UID của người dùng
                        'name_contact': _nameOfContactController.text,
                        'phone_number_contact': _phoneNumberOfContactController.text,
                        'timestamp': FieldValue.serverTimestamp(),
                      });

                      // Dọn dẹp các TextControllers sau khi gửi yêu cầu
                      _nameOfContactController.clear();
                      _phoneNumberOfContactController.clear();

                      showToast(message: "Thêm thành công");
                    } catch (e) {
                      showToast(message: "Lỗi khi gửi yêu cầu: $e");
                    };
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(55, 35, 41, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                          "Thêm mới",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 27,
                ),
                const Text(
                  "Danh sách liên lạc đã thêm",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 57, 116, 1),
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 420,
                    // Chiều cao cố định cho vùng cuộn
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('trust_contact')
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
                          return const Center(child: Text("Không có liên lạc tin cậy nào."));
                        }

                        List<Row> trustContactWidgets = [];
                        if (snapshot.hasData) {
                          final trustContacts =
                          snapshot.data?.docs.reversed.toList();
                          for (var trustContact in trustContacts!) {
                            final name =
                                trustContact['name_contact']?.toString() ?? 'N/A';
                            final phoneNumber =
                                trustContact['phone_number_contact']
                                    ?.toString() ??
                                    'N/A';

                            final trustContactWidget = Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 13),
                                  height: 75,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                     GestureDetector(
                                       onTap: ()
                                        => _launchPhoneCall(phoneNumber),
                                       child:  Column(
                                         crossAxisAlignment: CrossAxisAlignment.start
                                         ,children: [
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
                                         Text(
                                           phoneNumber,
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
                                       ],
                                       ),
                                     ),
                                      Column(
                                        children: [
                                          Container (
                                              margin: const EdgeInsets.only(top: 1),
                                              child: IconButton(
                                                onPressed: () {
                                                  var conllection = FirebaseFirestore.instance.collection('trust_contact');
                                                  conllection.doc(trustContact.id).delete();
                                                  showToast(message: "Xóa thành công");
                                                },
                                                icon: const FaIcon(
                                                  FontAwesomeIcons.solidTrashAlt, //
                                                  size: 22,
                                                  color: Colors.black,
                                                ),)
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                            trustContactWidgets.add(trustContactWidget);
                          }
                        }
                        else {
                          const CircularProgressIndicator();
                        }
                        return Expanded(
                            child: ListView(
                              children: trustContactWidgets,
                            ));
                      },
                    )),
              ],
            ),
          ),
        )
      ),
    );
  }
}

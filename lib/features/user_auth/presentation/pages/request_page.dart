import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../global/common/toast.dart';
import '../widgets/form_container_widget.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  //final FirebaseAuthServices _auth = FirebaseAuthServices();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;

        // Truy vấn thông tin người dùng từ Firestore
        DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (userDoc.exists) {
          Map<String, dynamic>? userData =
          userDoc.data() as Map<String, dynamic>?;

          // Cập nhật TextField với thông tin người dùng
          setState(() {
            _nameController.text = userData?['fullName'] ?? '';
            _ageController.text = userData?['age']?.toString() ?? '';
            _phoneNumberController.text = userData?['phoneNumber'] ?? '';
            _addressController.text = userData?['address'] ?? '';
          });
        } else {
          showToast(message: "Không tìm thấy thông tin người dùng!");
        }
      } else {
        showToast(message: "Người dùng chưa đăng nhập!");
      }
    } catch (e) {
      showToast(message: "Lỗi khi tải thông tin người dùng: $e");
    }
  }
  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //cho phép đè bàn phím lên giao diện

      appBar: AppBar(
        automaticallyImplyLeading:
            true, // tự động thêm nút back khi giao diện hiện tại không phải root
        title: const Text(
          "Gửi yêu cầu hổ trợ",
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
              SizedBox(
                height: 30,
              ),
              Text("Hãy nêu chính xác những gì đã xảy ra! *",
                  style: TextStyle(fontStyle: FontStyle.italic)
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                  child: FormContainerWidget(
                    controller: _detailsController,
                    maxLines: 5,
                    labelText: "Chi tiết sự việc",
                    hintText: "Nhập chi tiết sự việc đã xảy ra!",
                    applyBoxShadow: true,
                  )
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _nameController,
                isPasswordField: false,
                labelText: "Tên",
                hintText: "Nhập tên của bạn",
              ),
              const SizedBox(
                height: 10,
              ),

              FormContainerWidget(
                controller: _ageController,
                labelText: "Tuổi",
                hintText: "Nhập tuổi của bạn",
              ),

              const SizedBox(
                height: 10,
              ),

              FormContainerWidget(
                controller: _phoneNumberController,
                labelText: "Số điện thoại",
                hintText: "Nhập số điện thoại của bạn",
              ),

              const SizedBox(
                height: 10,
              ),

              FormContainerWidget(
                controller: _addressController,
                labelText: "Địa chỉ",
                hintText: "Nhập địa chỉ của bạn",
              ),

              const SizedBox(
                height: 30,
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
                          Navigator.pushNamed(context, "/request-detail");
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons
                              .solidEye, //
                          size: 22,
                          color: Color.fromRGBO(255, 57, 116, 1),
                        )
                    ),
                  )
                ],
              ),
              const SizedBox(
                  height: 50
              ),
              GestureDetector(
                onTap: () {
                  _sendSupportRequest();
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
                    "Gửi",
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
            ],
          ),
        ),
      )),
    );
  }

  void _sendSupportRequest() {
    try {
      // Lấy uid của người dùng hiện tại
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        showToast(message: "Người dùng chưa đăng nhập!");
        return;
      }
      String uid = currentUser.uid;

      // Truyền dữ liệu vào Firestore, bao gồm cả UID của người dùng
      CollectionReference collRef = FirebaseFirestore.instance.collection('support_requests');

      collRef.add({
        'userId': uid, // Lưu UID của người dùng
        'name': _nameController.text,
        'age': _ageController.text,
        'phoneNumber': _phoneNumberController.text,
        'address': _addressController.text,
        'details': _detailsController.text,
        'status': 0,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Dọn dẹp các TextControllers sau khi gửi yêu cầu
      _addressController.clear();
      _phoneNumberController.clear();
      _ageController.clear();
      _nameController.clear();
      _detailsController.clear();

      Navigator.pushNamed(context, "/request-detail");
      showToast(message: "Gửi yêu cầu thành công");
    } catch (e) {
      showToast(message: "Lỗi khi gửi yêu cầu: $e");
    }
  }

}

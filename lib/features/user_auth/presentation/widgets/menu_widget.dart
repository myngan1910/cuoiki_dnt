import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuWidget extends StatefulWidget {
  final double width;
  final double height;

  const MenuWidget({
    super.key,
    this.width = 390,
    this.height = 76.21483612060547,
  });

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  int selectedIndex = 0; // Ban đầu là home icon (index 0)

  void _onIconTap(int index) {
    setState(() {
      selectedIndex = index; // Cập nhật index khi chọn một icon
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          // Background Container
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, -7),
                    blurRadius: 4,
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment(1, 0),
                  end: Alignment(0, 1),
                  colors: [Color.fromRGBO(255, 57, 116, 1), Color.fromRGBO(255, 57, 116, 1)],
                ),
              ),
            ),
          ),
          // CircleAvatar always stays at the home position (left: 20)

          Positioned(
            top: 25,
            left: 33,
            child: GestureDetector(
              onTap: () => _onIconTap(0), // Chuyển đến icon Profile
              child: Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.home,
                    size: 27,
                    color: selectedIndex == 1 ? Color.fromRGBO(255, 236, 208, 1) : Color.fromRGBO(255, 236, 208, 1),
                  ),
                ],
              ),
            ),
          ),
          // Profile Icon
          Positioned(
            top: 25,
            left: 230,
            child: GestureDetector(
              onTap: () => _onIconTap(1), // Chuyển đến icon Profile
              child: Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.userAlt,
                    size: 25,
                    color: selectedIndex == 1 ? Colors.blue : Color.fromRGBO(255, 236, 208, 1),
                  ),
                ],
              ),
            ),
          ),
          // Setting Icon
          Positioned(
            top: 25,
            left: 325,
            child: GestureDetector(
              onTap: () => _onIconTap(2), // Chuyển đến icon Setting
              child: Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.cog,
                    size: 25,
                    color: selectedIndex == 2 ? Colors.blue : Color.fromRGBO(255, 236, 208, 1),
                  ),
                ],
              ),
            ),
          ),
          // Book Icon
          Positioned(
            top: 25,
            left: 141,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/request-detail');
              }, // Chuyển đến icon Book
              child: Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidFolderOpen,
                    size: 25,
                    color: selectedIndex == 3 ? Colors.blue : Color.fromRGBO(255, 236, 208, 1),
                  ),
                ],
              ),
            ),
          ),
          // CircleAvatar for the selected icon, always moves when a new icon is selected
          Positioned(
            top: 7,
            left: selectedIndex == 0
                ? 17 // Vị trí của home icon
                : selectedIndex == 1
                ? 210 // Vị trí của profile icon
                : selectedIndex == 2
                ? 307 // Vị trí của setting icon
                : 121, // Vị trí của book icon
            child: CircleAvatar(
              radius: 31,
              backgroundColor: Color.fromRGBO(255, 236, 208, 1),
              child: FaIcon(
                selectedIndex == 0
                    ? FontAwesomeIcons.home // Home icon khi selectedIndex == 0
                    : selectedIndex == 1
                    ? FontAwesomeIcons.userAlt // Profile icon khi selectedIndex == 1
                    : selectedIndex == 2
                    ? FontAwesomeIcons.cog // Setting icon khi selectedIndex == 2
                    : FontAwesomeIcons.solidFolderOpen, // Book icon khi selectedIndex == 3
                size: 28,
                color: Color.fromRGBO(255, 57, 116, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

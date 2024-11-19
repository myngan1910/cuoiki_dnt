// lib/widgets/gradient_rectangle_widget.dart
import 'package:flutter/material.dart';

class slideWidget extends StatefulWidget {
  const slideWidget({super.key});

  @override
  _slideWidgetState createState() => _slideWidgetState();
}

class _slideWidgetState extends State<slideWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.6);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 440), // Cách top 20 đơn vị
      child: SizedBox(
        width: 390,
        height: 235,
        child: PageView.builder(
          controller: _pageController,
          itemCount: 5,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double scale = 1.0;
                if (_pageController.position.haveDimensions) {
                  scale = _pageController.page != null
                      ? (1 - ((_pageController.page! - index).abs() * 0.3)).clamp(0.7, 1.0)
                      : 1.0;
                }
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: _buildCard(
                index: index,
                imagePath: 'assets/images/slide${1 + index}.png',
                title: _getTitle(index),
              ),
            );
          },
        ),
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Liên hệ tin tưởng';
      case 1:
        return 'Yêu cầu hổ trợ';
      case 2:
        return 'Chia sẽ vị trí';
      case 3:
        return 'Địa điểm an toàn';
      case 4:
        return 'Nhật ký của bạn';
      default:
        return '';
    }
  }

  Widget _buildCard({
    required int index,
    required String imagePath,
    required String title,
  }) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/contact2');
            break;
          case 1:
            Navigator.pushNamed(context, '/request');
            break;
          case 2:
            Navigator.pushNamed(context, '/contact');
            break;
          case 3:
            Navigator.pushNamed(context, '/contact');
            break;
          case 4:
            Navigator.pushNamed(context, '/contact');
            break;
          default:
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 188.24,
        height: 233,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 4,
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFF3974),
              Color(0xFFFAEBD5),
              Color(0xFFFF3974),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 143.5,
              height: 143.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF372329),
                fontFamily: 'Comfortaa',
                fontSize: 13,
                height: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}


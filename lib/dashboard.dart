import 'dart:math';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final String? userName; // Passed from login or fallback

  const DashboardPage({Key? key, this.userName}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  final Color pink = const Color(0xFFF45D6B);
  final Color darkText = const Color(0xFF282828);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 100),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _animatedDottedCircle(double radius) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: DottedCirclePainter(
            animation: _animation.value,
            color: pink,
            dotsCount: 50,
            radius: radius,
            dotRadius: 2,
          ),
          size: Size(radius * 2, radius * 2),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Proper null safety and fallback username
    final String displayName =
    (widget.userName ?? '').trim().isEmpty ? 'User' : widget.userName!;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 10,
        selectedItemColor: pink,
        unselectedItemColor: Colors.grey[400],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        onTap: (index) {
          if (index == 4) {
            Navigator.pushNamed(context, '/editprofile', arguments: {
              'name': displayName,
            });
          }
          // Add other navigation if needed
        },
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: -80,
              top: -90,
              child: Container(
                width: 240,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(170)),
                  gradient: LinearGradient(
                    colors: [pink.withOpacity(0.18), Colors.white],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 1),
                      const Expanded(
                        child: Text(
                          "New Delhi", // Could be dynamic in future
                          style: TextStyle(
                            fontSize: 15.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black87),
                        iconSize: 28,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/editprofile',
                            arguments: {'name': displayName},
                          );
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: pink,
                          child: const Icon(Icons.person, size: 26, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 18),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hi, ',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 27,
                              color: pink,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          TextSpan(
                            text: displayName,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              color: darkText,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _animatedDottedCircle(90),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: pink.withOpacity(0.10),
                          ),
                          child: const CircleAvatar(
                            radius: 71,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, color: Colors.grey, size: 85),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "in this chaos let's find your ",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Nunito',
                      ),
                      children: [
                        TextSpan(
                          text: "cosmos!",
                          style: TextStyle(
                            color: pink,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 34),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: pink,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 17),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Find a match',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: pink,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 17),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Explore',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for animated dotted circle
class DottedCirclePainter extends CustomPainter {
  final double animation;
  final Color color;
  final int dotsCount;
  final double radius;
  final double dotRadius;

  DottedCirclePainter({
    required this.animation,
    required this.color,
    this.dotsCount = 50,
    required this.radius,
    required this.dotRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    for (int i = 0; i < dotsCount; i++) {
      final double angle = (2 * pi / dotsCount) * i + animation;
      final double x = cx + radius * cos(angle);
      final double y = cy + radius * sin(angle);
      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant DottedCirclePainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

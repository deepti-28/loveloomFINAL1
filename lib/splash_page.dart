import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEE2EB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Scattered hearts above the logo
            SizedBox(
              height: 80,
              width: double.infinity,
              child: Stack(
                children: [
                  AnimatedHollowHeart(top: 10, left: 30, delay: 0),
                  AnimatedHollowHeart(top: 15, left: 80, delay: 200),
                  AnimatedHollowHeart(top: 5, right: 50, delay: 400),
                  AnimatedHollowHeart(top: 40, right: 20, delay: 600),
                  AnimatedHollowHeart(top: 60, left: 160, delay: 750),
                  AnimatedHollowHeart(top: 45, right: 110, delay: 900),
                  AnimatedHollowHeart(top: 22, left: 120, delay: 1200),
                  AnimatedHollowHeart(top: 60, right: 140, delay: 1450),
                ],
              ),
            ),

            // LOVE LOOM Logo with bold Montserrat font
            Text(
              'LOVE LOOM',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFFF45D6B),
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                fontFamily: 'Nunito',
              ),
            ),
            SizedBox(height: 6),
            RichText(
              text: TextSpan(
                text: 'Weaving ',
                style: TextStyle(color: Colors.black87, fontSize: 15),
                children: [
                  TextSpan(
                    text: 'connections',
                    style: TextStyle(color: Color(0xFFEE447A)),
                  ),
                  TextSpan(text: ' from coordinates'),
                ],
              ),
            ),
            SizedBox(height: 28),
            Image.asset(
              'assets/Group 1171275043.png',
              width: 230,
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 44),
            SizedBox(
              width: 260,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEE447A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  'Find your connection',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedHollowHeart extends StatefulWidget {
  final double top;
  final double? left;
  final double? right;
  final int delay;
  const AnimatedHollowHeart({this.top = 0, this.left, this.right, this.delay = 0});
  @override
  State<AnimatedHollowHeart> createState() => _AnimatedHollowHeartState();
}

class _AnimatedHollowHeartState extends State<AnimatedHollowHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2400),
      vsync: this,
    );
    _opacity = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      right: widget.right,
      child: FadeTransition(
        opacity: _opacity,
        child: Icon(
          Icons.favorite_border,
          color: Color(0xFFEE447A),
          size: 24,
        ),
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

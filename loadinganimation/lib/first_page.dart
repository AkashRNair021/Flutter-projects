import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'second_page.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with TickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Repeats the animation indefinitely.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onButtonPressed() {
    setState(() {
      _isLoading = true;
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SecondPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: _isLoading
            ? CustomPaint(
                painter: WhatsAppLoadingPainter(_controller),
                child: SizedBox(
                  width: 50,
                  height: 50,
                ),
              )
            : ElevatedButton(
                onPressed: _onButtonPressed,
                child: Image.asset(
                  'assets/sun.png',
                  width: 50,
                  height: 50,
                )
              ),
      ),
    );
  }
}

class WhatsAppLoadingPainter extends CustomPainter {
  final Animation<double> animation;

  WhatsAppLoadingPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final radius = min(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius);

    final startAngle = animation.value * 2 * pi;
    final sweepAngle = pi * 0.8; // Arc length of 80% of a full circle

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

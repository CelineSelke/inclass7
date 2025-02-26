import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenSwipe(),
    );
  }
}

class ScreenSwipe extends StatefulWidget {
  @override
  _ScreenSwipeState createState() => _ScreenSwipeState();
}

class _ScreenSwipeState extends State<ScreenSwipe> {
  final PageController controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          FadingTextAnimation(),
          FadingTextAnimation2(),        
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          controller.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.circle, color: _currentPage == 0 ? Colors.blue : Colors.grey), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.circle, color: _currentPage == 1 ? Colors.blue : Colors.grey), label: ""),
        ],
      ),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class FadingTextAnimation2 extends StatefulWidget {
  @override
  _FadingTextAnimationState2 createState() => _FadingTextAnimationState2();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

class _FadingTextAnimationState2 extends State<FadingTextAnimation2> {
  bool _animate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 1.0, end: _animate ? 0: 1),
          duration: Duration(seconds: 2),
          builder: (context, double opacity, child) {
            return Opacity(
              opacity: opacity,
              child: Transform.rotate(
                angle: opacity * 2 * pi, // Full spin (2π radians)
                child: child,
              ),
            );
          },
          child: Text(
            'GoodBye, Flutter!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
          setState(() {
            _animate = !_animate;
          });
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

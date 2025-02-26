import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'dart:math';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => ThemeProvider(), child: MyApp(),));
  
}

class ThemeProvider with ChangeNotifier{
    ThemeData themeMode = ThemeData.light();
    Color currentColor = Colors.black;
    
    void setColor(Color color) {
        currentColor = color;
        notifyListeners();
    }

    void changeThemeDay() {
        themeMode = ThemeData.light();
        notifyListeners();
    }

    void changeThemeNight() {
        themeMode = ThemeData.dark();
        notifyListeners();
    
    }
}

class MyApp extends StatelessWidget {

  FadingTextAnimation app = FadingTextAnimation();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenSwipe(),
      theme: context.watch<ThemeProvider>().themeMode,
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
  late ColorPicker picker;
  Color currentColor = Colors.white;

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
        actions: [ 
          Consumer<ThemeProvider>(builder: (context, themes, child) => IconButton(onPressed: () {var theme = context.read<ThemeProvider>(); theme.changeThemeDay();}, icon: const Icon(Icons.sunny))), 
          Consumer<ThemeProvider>(builder: (context, themes, child) =>IconButton(onPressed: () {var theme = context.read<ThemeProvider>(); theme.changeThemeNight();}, icon: const Icon(Icons.shield_moon))), 
          Consumer<ThemeProvider>(builder: (context, themes, child) =>(IconButton(onPressed: 
                      () {showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                              return AlertDialog(title: Text("Select Color"), 
                                  content: ColorPicker(
                                        pickerColor: themes.currentColor, 
                                        onColorChanged: (Color color) {var theme = context.read<ThemeProvider>(); theme.setColor(color);},
                                        paletteType: PaletteType.hueWheel,));});}, 
                      icon: Icon(Icons.water_drop_outlined)))) ],
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Text(
            'Hello, Flutter!',
            style: 
            TextStyle(
              fontSize: 24
            ),
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
  late ColorPicker picker;
  Color currentColor = Colors.white;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [ 
          Consumer<ThemeProvider>(builder: (context, themes, child) => IconButton(onPressed: () {var theme = context.read<ThemeProvider>(); theme.changeThemeDay();}, icon: const Icon(Icons.sunny))), 
          Consumer<ThemeProvider>(builder: (context, themes, child) =>IconButton(onPressed: () {var theme = context.read<ThemeProvider>(); theme.changeThemeNight();}, icon: const Icon(Icons.shield_moon))), 
          Consumer<ThemeProvider>(builder: (context, themes, child) =>(IconButton(onPressed: 
                      () {showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                              return AlertDialog(title: Text("Select Color"), 
                                  content: ColorPicker(
                                        pickerColor: themes.currentColor, 
                                        onColorChanged: (Color color) {var theme = context.read<ThemeProvider>(); theme.setColor(color);},
                                        paletteType: PaletteType.hueWheel,));});}, 
                      icon: Icon(Icons.water_drop_outlined)))) ],
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
          child: Consumer<ThemeProvider>(
            builder: (context, themes, child) {
              return Text(
                'GoodBye, Flutter!',
                style: TextStyle(
                  fontSize: 24,
                  color: context.watch<ThemeProvider>().currentColor,
                ),
              );
          },
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

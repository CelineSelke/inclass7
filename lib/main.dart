import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  FadingTextAnimation app = FadingTextAnimation();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: app,
      theme: app.getTheme();
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  ThemeData themeMode = ThemeData.light();
  late ColorPicker picker;
  Color currentColor = Colors.white;

  ThemeData getTheme(){
      return themeMode;
  }

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void changeThemeDay() {
      setState() {
          themeMode = ThemeData.light();
      }
  }

    void changeThemeNight() {
      setState() {
          themeMode = ThemeData.dark();
      }
    }

    
    void setColor(Color color) {
        setState(){
           currentColor = color;
        }
    }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [ 
          IconButton(onPressed: changeThemeDay, icon: const Icon(Icons.sunny)), 
          IconButton(onPressed: changeThemeNight, icon: const Icon(Icons.shield_moon)), 
          IconButton(onPressed: 
                      () {showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                              return AlertDialog(title: Text("Select Color"), 
                                  content: ColorPicker(
                                        pickerColor: currentColor, 
                                        onColorChanged: setColor,
                                        paletteType: PaletteType.hueWheel,));});}, 
                      icon: Icon(Icons.water_drop_outlined)) ],
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

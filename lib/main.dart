import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


void main() {
  runApp(ChangeNotifierProvider(create: (context) => ThemeProvider(), child: MyApp(),));
  
}

class ThemeProvider with ChangeNotifier{
    ThemeData themeMode = ThemeData.light();
    Color currentColor = Colors.white;
    
    
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAnimation(),
      theme: context.watch<ThemeProvider>().themeMode,
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
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
                                        pickerColor: currentColor, 
                                        onColorChanged: (Color color) {var theme = context.watch<ThemeProvider>(); theme.setColor(color);},
                                        paletteType: PaletteType.hueWheel,));});}, 
                      icon: Icon(Icons.water_drop_outlined)))), ],
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

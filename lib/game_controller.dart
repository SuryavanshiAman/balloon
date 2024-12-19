import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameController with ChangeNotifier{
  double _balloonSize = 250.0; // Initial size
  late double _burstThreshold;
  bool _isFlying = false;
  bool _isButtonPressed = false;
   double _sizeIncrement = 3.0; // Size increase per tick
  final List<String> amount = ['2', '5', '10', '15','20','25','30'];
  int _selectedIndex = 1;
  double _multipliedValue = 0.0;

  double get balloonSize=>_balloonSize;
  setBalloonSize(double value){
    _balloonSize=value;
    notifyListeners();
  }
double get burstThreshold=>_burstThreshold;
  setBurstThreshold(double value){
    _burstThreshold=value;
    notifyListeners();
  }

  bool get isFlying=>_isFlying;
  setIsFlying(bool value){
    _isFlying=value;
    notifyListeners();
  }
  bool get isButtonPressed => _isButtonPressed;
  setIsButtonPressed(bool value){
    _isButtonPressed=value;
    notifyListeners();
  }
  double get sizeIncrement=>_sizeIncrement;
  setSizeIncrement(double value){
    _sizeIncrement=value;
    notifyListeners();
  }
  int get selectedIndex=>_selectedIndex;
  setSelectedIndex(int value){
    _selectedIndex=value;
    notifyListeners();
  }
  double get multipliedValue=>_multipliedValue;
  setMultipliedValue(double value){
    _multipliedValue=value;
  }
}
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText({
    Key? key,
    required this.text,
    required this.style,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white), // Color is ignored due to ShaderMask
      ),
    );
  }
}
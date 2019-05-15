import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final String size;
  final Color color;

  CircularProgress({
    this.size = 'default',
    this.color,
  });

  static const Map<String, double> sizes = {
    'small': 20.0,
    'default': 30.0,
    'large': 40.0,
  };

  @override
  Widget build(BuildContext context) {
    double chosenSize = sizes[size];
    AlwaysStoppedAnimation<Color> chosenColor = getColor(context, color);

    return Center(
      child: SizedBox(
        height: chosenSize,
        width: chosenSize,
        child: CircularProgressIndicator(
          valueColor: chosenColor,
        ),
      ),
    );
  }

  getColor(BuildContext context, color) {
    Color chosenColor = color is Color ? color : Theme.of(context).primaryColor;
    return AlwaysStoppedAnimation<Color>(chosenColor);
  }
}

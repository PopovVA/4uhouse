import 'package:flutter/material.dart';

class StyledCircularProgress extends StatelessWidget {
  const StyledCircularProgress({
    this.size = 'default',
    this.color,
  });

  final String size;
  final Color color;

  static const Map<String, double> sizes = <String, double>{
    'small': 20.0,
    'default': 30.0,
    'large': 40.0,
  };

  @override
  Widget build(BuildContext context) {
    final double chosenSize = sizes[size];
    final AlwaysStoppedAnimation<Color> chosenColor = getColor(context, color);

    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: SizedBox(
          height: chosenSize,
          width: chosenSize,
          child: CircularProgressIndicator(
            valueColor: chosenColor,
          ),
        ),
      ),
    );
  }

  AlwaysStoppedAnimation<Color> getColor(BuildContext context, Color color) {
    final Color chosenColor =
        color is Color ? color : Theme.of(context).primaryColor;
    return AlwaysStoppedAnimation<Color>(chosenColor);
  }
}

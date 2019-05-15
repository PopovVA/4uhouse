import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoPicker;

import 'debouncer.dart';

class Picker extends StatefulWidget {
  Picker({
    @required this.controller,
    @required this.index,
    @required this.rangeList,
    this.animateDuration,
    this.displayFunction,
    this.looping = false,
    this.onSelectedItemChanged,
  });

  final FixedExtentScrollController controller;
  final int index;
  final List<int> rangeList;

  final int animateDuration;
  final Function displayFunction;
  final bool looping;
  final Function onSelectedItemChanged;

  @override
  State<StatefulWidget> createState() {
    return _PickerState();
  }
}

class _PickerState extends State<Picker> {
  final _debouncer = Debouncer(milliseconds: 700);
  int realIndex;
  bool isDragging;

  static List<Widget> generateListOfItems(
      List<int> list, Function displayFunction, context) {
    Function renderer = (value) => value;

    if (displayFunction is Function) {
      renderer = displayFunction;
    }

    return List.generate(list.length, (int i) {
      int value = list[i];
      return Container(
        height: 10.0,
        alignment: Alignment.center,
        child: Text(
          renderer(value.abs()).toString(),
          style: TextStyle(
            fontSize: 16.0,
            color: value < 0 ? Colors.grey : Colors.black,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    realIndex = widget.index;
    super.initState();
  }

  @override
  void didUpdateWidget(Picker oldWidget) {
    if (widget.animateDuration is int) {
      if (widget.index != realIndex) {
        animateToRightIndex();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  animateToRightIndex() {
    _debouncer.run(() {
      widget.controller.animateToItem(
        widget.index,
        duration: Duration(seconds: 1),
        curve: Cubic(0, 0, 0.58, 1),
      );
    });
  }

  Widget build(BuildContext build) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 200.0,
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: CupertinoPicker(
          backgroundColor: Colors.white,
          children: _PickerState.generateListOfItems(
            widget.rangeList,
            widget.displayFunction,
            context,
          ),
          magnification: 1.1,
          itemExtent: 45.0,
          onSelectedItemChanged: (int index) {
            realIndex = index;
            widget.onSelectedItemChanged(index);
          },
          scrollController: widget.controller,
          useMagnifier: true,
          looping: widget.looping,
        ),
      ),
    );
  }
}

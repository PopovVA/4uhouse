import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget implements SnackBar {
  const CustomSnackBar({
    @required this.content,
    this.backgroundColor,
    this.action,
    this.animation
  });


  @override
  final Widget content;
  @override
  final Color backgroundColor;
  @override
  final SnackBarAction action;

  @override
  Duration get duration => Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      key: key,
      content: content,
      backgroundColor: backgroundColor,
      action: action,
      duration: duration,
      animation: animation,
    );
  }

  @override
 final Animation<double> animation ;

  @override
  SnackBar withAnimation(Animation<double> newAnimation, {Key fallbackKey}) {
    return SnackBar(
      key: key,
      content: content,
      backgroundColor: backgroundColor,
      action: action,
      duration: duration,
      animation: newAnimation,
    );
  }

  /*
    final SnackBarBloc snackBarBloc = SnackBarBloc();

  Scaffold(
          body: BlocBuilder<String,CustomSnackBar>(
            bloc: snackBarBloc,
            builder: (BuildContext context, CustomSnackBar snackBar) {
              return Builder(builder: (BuildContext context) {
                return Center(
                  child: RaisedButton(
                      child: const Text('Click'),
                      onPressed: () {
                        snackBarBloc.dispatch('New text after click');
                        Scaffold.of(context).showSnackBar(snackBar);
                      }),
                );
              });
            },
          ),
        )*/
}

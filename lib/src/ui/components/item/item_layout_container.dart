import 'package:flutter/material.dart';
import '../../../constants/layout.dart' show standardPadding;

class ItemLayoutContainer extends StatelessWidget {
  final Function onTap;
  final dynamic child;
  
  ItemLayoutContainer(this.child, {this.onTap});
	
  @override
  Widget build(BuildContext context) {
  	if (onTap is Function) {
  		return InkWell(
			  onTap: onTap,
			  child: buildContainer(child),
		  );
    }
    
    return buildContainer(child);
  }
  
  buildContainer(child) {
  	return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 52.0,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: standardPadding),
          child: child,
      ),
  	);
  }
}


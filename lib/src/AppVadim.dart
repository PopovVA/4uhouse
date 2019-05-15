import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_mobile/src/ui/components/common/page_template_maxim.dart';
import 'package:provider_mobile/src/utils/rout_transition.dart';

import 'pallete.dart';
import 'typography.dart';
import 'ui/pages/screen.dart';
import 'ui/components/common/page_template.dart';
import 'ui/components/common/styled_button.dart';

import 'ui/pages/property/description.dart';
import 'ui/pages/property/main_points.dart';
import 'ui/pages/property/sub_points.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplateMaxim(
        title: 'My property',
        body: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 21),
                width: 180,
                height: 180,
                child: SvgPicture.asset('lib/assets/dog.svg')),
            Padding(padding: EdgeInsets.only(top: 17), child: Description()),
            Padding(
                padding: EdgeInsets.only(top: 16),
                child: MainPoint(
                    'Fill in some property information and send it to us', 1)),
            Padding(
                padding: EdgeInsets.only(top: 12),
                child: MainPoint(
                    'Choose a meeting time on the property and then we will do everything ourselves',
                    2)),
            Padding(
                padding: EdgeInsets.only(top: 12),
                child: SubPoint('Prepare and sign a contract with you')),
            Padding(
                padding: EdgeInsets.only(right: 43),
                child: SubPoint('Create a virtual property tour')),
            Padding(
                padding: EdgeInsets.only(right: 28),
                child: SubPoint('Prepare a property specification')),
            Padding(
                padding: EdgeInsets.only(right: 13),
                child: SubPoint('Prepare information for publication')),
            Padding(
                padding: EdgeInsets.only(top: 13),
                child: MainPoint('Agree on information for publication', 3)),
            Padding(
                padding: EdgeInsets.only(top: 9, left: 15.0, right: 15.0),
                child: StyledButton(
                  text: 'Add a property',
                )),
          ],
        ));
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4u.house',
      theme: ThemeData(
          accentColor: accentColor,
          primaryColor: primaryColor,
          textTheme: customTextTheme),
      home: Screen("2"),
      onGenerateRoute: (RouteSettings settings) {
        return SlideRoute(widget: Screen(settings.name));
      },
    );
  }
}

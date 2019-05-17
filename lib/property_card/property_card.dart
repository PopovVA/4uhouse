import 'package:flutter/material.dart';


class PropertyCard extends StatelessWidget {
 final  TextStyle caption = const TextStyle(
    color:  Color(0xFF000000),
    fontSize: 12.0,
  );
 final TextStyle captionBold = const TextStyle(
    color: Color(0xFFCC000000),
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
  );
 final  TextStyle body1 = const  TextStyle(
    color:  Color(0xFFCC000000),
    fontSize: 14.0,
  );
 final  TextStyle heading =const  TextStyle(
    color: Color(0xFFDD000000),
    fontSize: 20.0,
  );

  Widget _renderHeading(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Container(
        height: 30.0,
        margin:const  EdgeInsets.only(top: 12.0, right: 7.0, bottom: 22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /* LEFT */
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: viewportConstraints.maxWidth / 2.3,
              ),
              child: Container(
                margin:const  EdgeInsets.only(left: 16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin:const  EdgeInsets.only(right: 10.0),
                      child: Text(
                        'ID 01123',
                        style: caption,
                      ),
                    ),
                    Text(
                      '12.12.2019',
                      style: caption,
                    ),
                  ],
                ),
              ),
            ),

            /* RIGHT */
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('#meeting at the property', style: captionBold),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 8.0,
                            height: 8.0,
                            margin:const  EdgeInsets.only(right: 4.0, top: 2.0),
                            decoration:const  BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFffa726),
                            ),
                          ),
                          Text('prepare the property...', style: body1),
                        ],
                      ),
                    ],
                  ),const
                  Icon(
                    Icons.more_vert,
                    color: Color(0xFF8a000000),
                    size: 35.0,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _renderBody(BuildContext context) {
    return Padding(
      padding:const  EdgeInsets.only(right: 11.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /* IMAGE */
          Container(
            width: 110.0,
            height: 66.0,
            margin:const  EdgeInsets.only(right: 16.0),
            child: Image.network(
              'https://images.homify.com/image/upload/a_0,c_limit,f_auto,h_1024,q_auto,w_1024/v1478609817/p/photo/image/1695561/Alman-ev-tasar%C4%B1m%C4%B1-natural-light-apartment-2-19.jpg',
            ),
          ),

          /* RIGHT */
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /* header */
                Container(
                  margin:const  EdgeInsets.only(bottom: 8.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Rent: \€1500/', style: captionBold),
                         const  Text('month',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Color(0xFF000000),
                              )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Sale: \€ 150 000', style: captionBold),
                        ],
                      ),
                    ],
                  ),
                ),

                /* body */
                Text('Apartaments, 110 m2', style: heading),
                /* bottom */
                Container(
                  margin:const  EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: const <Widget>[
                       Icon(
                        Icons.location_on,
                        color: Color(0xFF5c5c5c),
                        size: 13.3,
                      ),
                      Text('3002, Paphos, Ebma',
                          style: TextStyle(
                              color: Color(0xFF99000000), fontSize: 14.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 Widget _renderBottom(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        const Text('property process',
            style: TextStyle(color:Color(0xFFd4000000), fontSize: 14.0)),
        Expanded(
          child: Container(
            margin:const  EdgeInsets.only(left: 8.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color:const  Color(0xFF61424141),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.0,
      width: double.infinity,
      margin:const  EdgeInsets.only(bottom: 21.0),
      child: Column(
        children: <Widget>[
          _renderHeading(context),
          Expanded(
            child: Container(
              margin:const  EdgeInsets.only(left: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _renderBody(context),
                  _renderBottom(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PhoneSearch extends StatefulWidget {
  @override
  _PhoneSearchState createState() => _PhoneSearchState();

  PhoneSearch({this.favorites, @required this.rest});

  List<String> favorites;
  List<String> rest;
}

class _PhoneSearchState extends State<PhoneSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: const Color(0xFFe9e7e7),
          floating: true,
          forceElevated: true,
          snap: true,
          title: const Text("Select country"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                      favorites: widget.favorites, rest: widget.rest),
                );
              },
            ),
          ],
        )
      ],
    ));
  }
}

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({this.favorites, @required this.rest});
  List<String> favorites;
  List<String> rest;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> dummySearchList = List<String>();
    if (query.isNotEmpty) {
      rest.forEach((String item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummySearchList.add(item);
        }
      });
      if (dummySearchList.isNotEmpty) {
        return _buildRows();
      }
    }
    if (dummySearchList.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: const Text(
              "Country code is not fount",
            ),
          )
        ],
      );
    }
  }

  Widget _buildRows() {
    List<String> totalList = [];
    if (favorites.isNotEmpty) {
      totalList..addAll(favorites);
    }
    totalList..addAll(rest);
    return ListView.builder(
//        shrinkWrap: true,
        itemCount: totalList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: favorites.isNotEmpty && index <= favorites.length - 1
                ? Text('${totalList[index]}')
                : index == favorites.length
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Divider(height: 15.0, color: Colors.black),
                          const Padding(padding: EdgeInsets.only(bottom: 15.0)),
                          Text('${totalList[index]}')
                        ],
                      )
                    : Text('${totalList[index]}'),
            onTap: () => {print('Тут будет колбэк')},
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _buildRows();
    } else
      return Container();
  }
}

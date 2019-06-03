import 'package:flutter/material.dart';

class PhoneSearch extends StatefulWidget {
  @override
  _PhoneSearchState createState() => _PhoneSearchState();
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
                  delegate: CustomSearchDelegate(),
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
  final List<String> _list = <String>['United states +1', 'Cyprus +357'];

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
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> dummySearchList = List<String>();
    if (query.isNotEmpty) {
      _list.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummySearchList.add(item);
        }
      });
      if (dummySearchList.isNotEmpty) {
        return _buildRows(dummySearchList);
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

  Widget _buildRows(List<String> list) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${list[index]}'),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _buildRows(_list);
    } else
      return Container();
  }
}

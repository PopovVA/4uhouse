import 'package:flutter/material.dart';
import '../../../models/country_phone_data.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({this.favorites, @required this.rest});
  List<String> favorites;
  List<CountryPhoneData> rest;

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
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
    final List<CountryPhoneData> dummySearchList = <CountryPhoneData>[];
    if (query.isNotEmpty) {
      dummySearchList.addAll(rest.where((CountryPhoneData item) =>
          item.name.toLowerCase().contains(query.toLowerCase())));

      if (dummySearchList.isNotEmpty) {
        return _buildSearchRows(dummySearchList);
      }
    }
    if (dummySearchList.isEmpty) {
      return _buildRows();
    }
    return Container();
  }

  Widget _buildRows() {
    final List<CountryPhoneData> totalList = <CountryPhoneData>[];
    if (favorites.isNotEmpty) {
      favorites.forEach((String fav) => totalList.addAll(rest.where(
          (CountryPhoneData item) =>
              item.countryId.toLowerCase().contains(fav.toLowerCase()))));
    }
    print(totalList);
    totalList..addAll(rest);

    return ListView.builder(
        itemCount: totalList.length,
        itemBuilder: (BuildContext context, int index) {
          return favorites.isNotEmpty && index == favorites.length - 1
              ? Column(
                  children: <Widget>[
                    ListTile(
                        title: Text(
                            '${totalList[index].name + ' +' + totalList[index].code.toString()}'),
                        onTap: () => {print('Тут будет колбэк')}),
                    const Divider(height: 10.0, color: Colors.black)
                  ],
                )
              : ListTile(
                  title: Text(
                      '${totalList[index].name + ' +' + totalList[index].code.toString()}'),
                  onTap: () => {print('Тут будет колбэк')});
        });
  }

  Widget _buildSearchRows(List<CountryPhoneData> totalList) {
    return ListView.builder(
        itemCount: totalList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Text(
                  '${totalList[index].name + ' +' + totalList[index].code.toString()}'),
              onTap: () => {print('Тут будет колбэк')});
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

import 'package:flutter/material.dart';
import '../../../../models/country_phone_data.dart';

class CustomSearchDelegate extends SearchDelegate<CountryPhoneData> {
  CustomSearchDelegate(
      {this.favorites,
      @required this.countryPhoneDataList,
      @required this.onSelected});
  List<String> favorites;
  List<CountryPhoneData> countryPhoneDataList;
  Function onSelected;

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
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<CountryPhoneData> dummySearchList = <CountryPhoneData>[];
    if (query.isNotEmpty) {
      dummySearchList.addAll(countryPhoneDataList.where(
          (CountryPhoneData item) =>
              (item.name.toLowerCase() + item.code.toString())
                  .contains(query.toLowerCase())));

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
      for (String fav in favorites) {
        totalList.addAll(countryPhoneDataList.where((CountryPhoneData item) =>
            item.countryId.toLowerCase().contains(fav.toLowerCase())));
      }
    }
    totalList..addAll(countryPhoneDataList);

    return ListView.builder(
        itemCount: totalList.length,
        itemBuilder: (BuildContext context, int index) {
          return favorites.isNotEmpty && index == favorites.length - 1
              ? Column(
                  children: <Widget>[
                    ListTile(
                        title: Text(
                            '${"🇷🇺 " + totalList[index].name + ' +' + totalList[index].code.toString()}'),
                        onTap: () {
                          return onSelected is Function
                              ? onSelected(close(context, totalList[index]))
                              : Navigator.pop(context);
                        }),
                    const Divider(height: 10.0, color: Colors.black)
                  ],
                )
              : ListTile(
                  title: Text(
                      '${"🇷🇺 " + totalList[index].name + ' +' + totalList[index].code.toString()}'),
                  onTap: () {
                    return onSelected is Function
                        ? onSelected(close(context, totalList[index]))
                        : Navigator.pop(context);
                  });
        });
  }

  Widget _buildSearchRows(List<CountryPhoneData> totalList) {
    return ListView.builder(
        itemCount: totalList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Text(
                  '${"🇷🇺 " + totalList[index].name + ' +' + totalList[index].code.toString()}'),
              onTap: () {
                return onSelected is Function
                    ? onSelected(close(context, totalList[index]))
                    : Navigator.pop(context);
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _buildRows();
    } else {
      final List<CountryPhoneData> dummySearchList = <CountryPhoneData>[];
      if (query.isNotEmpty) {
        dummySearchList.addAll(countryPhoneDataList.where(
            (CountryPhoneData item) =>
                (item.name.toLowerCase() + item.code.toString())
                    .contains(query.toLowerCase())));

        if (dummySearchList.isNotEmpty) {
          return _buildSearchRows(dummySearchList);
        }
      }
    }
    return Container();
  }
}

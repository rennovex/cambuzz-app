import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/screens/search_screen.dart';

class SearchFilters extends StatelessWidget {
  final filterType;
  final selectedIndex;
  final setFilter;

  SearchFilters(this.filterType, this.selectedIndex, this.setFilter);

  // const SearchFilters({ Key? key }) : super(key: key);
  final List<Map<String, Object>> _filters = [
    {
      'name': 'Web Developers',
      'color': Color.fromRGBO(4, 110, 187, 0.69),
    },
    {
      'name': 'App Developers',
      'color': Color.fromRGBO(200, 121, 2, 0.78),
    },
    {
      'name': 'Ui Designers',
      'color': Color.fromRGBO(0, 111, 71, 0.86),
    },
    {
      'name': 'Singers',
      'color': Color.fromRGBO(74, 2, 165, 0.79),
    },
    {
      'name': 'Dancers',
      'color': Color.fromRGBO(191, 0, 149, 0.80),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filterType == FilterType.Selected ? 1 : _filters.length,
      itemBuilder: (ctx, ind) => Card(
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        color: _filters[filterType == FilterType.Selected ? selectedIndex : ind]
            ['color'],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        child: ListTile(
          onTap: () {
            setFilter(FilterType.Selected, ind);
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: Text(
            '${_filters[filterType == FilterType.Selected ? selectedIndex : ind]['name']}',
            style: kSearchFilterText,
          ),
          trailing: Icon(
            Icons.filter_alt,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

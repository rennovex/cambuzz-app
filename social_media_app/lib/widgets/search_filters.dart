import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/screens/search_screen.dart';

import '../dummy_data.dart';

class SearchFilters extends StatelessWidget {
  final filterType;
  final selectedIndex;
  final setFilter;

  SearchFilters(this.filterType, this.selectedIndex, this.setFilter);

  // const SearchFilters({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filters.length,
      itemBuilder: (ctx, ind) => Card(
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        color: filters[ind]['color'],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        child: ListTile(
          onTap: () {
            setFilter(FilterType.Selected, ind);
            showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                    filterType: FilterType.Selected, selectedIndex: ind));
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: Text(
            '${filters[ind]['name']}',
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

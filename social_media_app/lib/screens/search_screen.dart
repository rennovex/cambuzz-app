import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/widgets/app_bar.dart';
// import 'package:social_media_app/widgets/searchfilters.dart';
import 'package:social_media_app/widgets/search_filters.dart';
import 'package:social_media_app/widgets/search_results.dart';

import '../dummy_data.dart';

enum FilterType {
  All,
  Selected,
}

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _filterType;
  var _selectedIndex;

  @override
  void initState() {
    _filterType = FilterType.All;
    super.initState();
  }

  void setFilter(filter, index) {
    setState(() {
      _filterType = filter;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context, _filterType, _selectedIndex),
        body: CustomPaint(
          // size: MediaQuery.of(context).size,
          painter: SearchPainter(),

          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CustomAppBar(),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 20,
                      bottom: 10,
                    ),
                    child: Text(
                      'Filters',
                      style: kSearchTitle,
                    ),
                  ),
                  SearchFilters(_filterType, _selectedIndex, setFilter),
                  // if (_filterType == FilterType.Selected) SearchResults(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context, filterType, selectedIndex) {
  return AppBar(
    toolbarHeight: 50,
    title: GestureDetector(
      onTap: () async {
        await showSearch(
          context: context,
          delegate: CustomSearchDelegate(
            filterType: filterType,
            selectedIndex: selectedIndex,
          ),
        );
      },
      child: Container(
        height: 38,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
            Text('Search'),
          ],
        ),
      ),
    ),
  );
}

class CustomSearchDelegate extends SearchDelegate {
  final FilterType filterType;
  final selectedIndex;
  CustomSearchDelegate({
    this.filterType = FilterType.All,
    this.selectedIndex,
  });
  List searchResult;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(
          Icons.clear,
        ),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: searchResult.length,
      itemBuilder: (_, ind) => ListTile(
        title: Text(searchResult[ind]['name']),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(searchResult[ind]['image']),
        ),
        onTap: () => close(context, searchResult[ind]),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: Api.getCommunitySearch(key: query),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          // return SearchScreen();
          if (filterType == FilterType.Selected)
            return Card(
              margin: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 15,
              ),
              color: filters[selectedIndex]['color'],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              child: ListTile(
                onTap: () {
                  // setFilter(FilterType.Selected, ind);
                  Navigator.of(context).pop();
                },
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                leading: Text(
                  '${filters[selectedIndex]['name']}',
                  style: kSearchFilterText,
                ),
                trailing: Icon(
                  Icons.filter_alt,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            );
          if (filterType == FilterType.All)
            return Center(
              child: Text('No Data'),
            );
        }
        searchResult = snapshot.data;
        return SingleChildScrollView(
          child: Column(
            children: [
              if (filterType == FilterType.Selected)
                Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 15,
                  ),
                  color: filters[filterType == FilterType.Selected
                      ? selectedIndex
                      : selectedIndex]['color'],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: ListTile(
                    onTap: () {
                      // setFilter(FilterType.Selected, ind);
                      print('pop');
                      return Navigator.of(context).pop();
                    },
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: Text(
                      '${filters[filterType == FilterType.Selected ? selectedIndex : selectedIndex]['name']}',
                      style: kSearchFilterText,
                    ),
                    trailing: Icon(
                      Icons.filter_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (_, ind) => ListTile(
                  title: Text(snapshot.data[ind]['name']),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data[ind]['image']),
                  ),
                  onTap: () => close(context, snapshot.data[ind]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SearchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();

    //Start paint from 30% height to the left
    ovalPath.moveTo(0, height * 0.35);

    //Paint a curve from current position to end
    ovalPath.quadraticBezierTo(width * 0.8, height * 0.4, width, height * 0.8);

    ovalPath.lineTo(width, height);
    ovalPath.lineTo(0, height);

    paint.color = Color.fromRGBO(51, 51, 51, 1);
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

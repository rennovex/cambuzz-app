import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/models/searchItem.dart';
import 'package:social_media_app/models/skill.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/widgets/app_bar.dart';
// import 'package:social_media_app/widgets/searchfilters.dart';
import 'package:social_media_app/widgets/search_results.dart';

import '../dummy_data.dart';
import 'Profiles/community_profile_screen.dart';
import 'Profiles/user_profile_screen.dart';

enum FilterType {
  All,
  Selected,
}

enum ProfileType {
  UserProfile,
  CommunityProfile,
}

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  Future _future;
  Skill _filterType;
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    // _filterType = FilterType.All;
    _future = Api.getSkills();
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
                  FutureBuilder(
                      future: _future,
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (_, ind) => Card(
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
                                  // setFilter(FilterType.Selected, ind);
                                  showSearch(
                                      context: context,
                                      delegate: CustomSearchDelegate(
                                          filterType: snapshot.data[ind],
                                          selectedIndex: ind));
                                },
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                leading: Text(
                                  '${snapshot.data[ind].name}',
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
                      }),
                  // SearchFilters(_filterType, _selectedIndex, setFilter),
                  // if (_filterType == FilterType.Selected) SearchResults(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// Widget buildFilter(int ind, setFilter) => Card(
//       margin: EdgeInsets.symmetric(
//         vertical: 5,
//         horizontal: 15,
//       ),
//       color: filters[ind]['color'],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(13),
//       ),
//       child: ListTile(
//         onTap: () {
//           setFilter(FilterType.Selected, ind);
//           showSearch(
//               context: context,
//               delegate: CustomSearchDelegate(
//                   filterType: FilterType.Selected, selectedIndex: ind));
//         },
//         contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         leading: Text(
//           '${filters[ind]['name']}',
//           style: kSearchFilterText,
//         ),
//         trailing: Icon(
//           Icons.filter_alt,
//           color: Colors.white,
//           size: 30,
//         ),
//       ),
//     );

AppBar buildAppBar(BuildContext context, filterType, selectedIndex) {
  return AppBar(
    foregroundColor: Colors.black,
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
            color: Color.fromRGBO(82, 82, 82, 1),
            borderRadius: BorderRadius.circular(10)),
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
  final Skill filterType;
  final selectedIndex;
  CustomSearchDelegate({
    this.filterType,
    this.selectedIndex,
  });
  List searchResult;
  String prevQuery;

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
    return CustomPaint(
      // size: MediaQuery.of(context).size,
      painter: SearchPainter(),

      child: ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: FutureBuilder(
          future: filterType == null
              ? Api.getSearch(key: query)
              : Api.getSearchWithFilter(skillId: filterType.id, key: query),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (!snapshot.hasData) {
              // return SearchScreen();
              if (filterType != null)
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 75,
                        decoration: BoxDecoration(
                          color: filters[selectedIndex]['color'],
                          borderRadius: BorderRadius.circular(13),
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        // color: filters[selectedIndex]['color'],
                        child: ListTile(
                          onTap: () {
                            // setFilter(FilterType.Selected, ind);
                            Navigator.of(context).pop();
                          },
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          leading: Text(
                            '${filterType.name}',
                            style: kSearchFilterText,
                          ),
                          trailing: Icon(
                            Icons.filter_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              if (filterType == null)
                return Center(
                  child: Text('No Data'),
                );
            }
            searchResult = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (filterType != null)
                    Card(
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
                          print('pop');
                          return Navigator.of(context).pop();
                        },
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        leading: Text(
                          '${filterType.name}',
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
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, ind) =>
                        buildSearchItem(snapshot.data[ind], context),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return CustomPaint(
      // size: MediaQuery.of(context).size,
      painter: SearchPainter(),

      child: ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: FutureBuilder(
          future: filterType == null
              ? Api.getSearch(key: query)
              : Api.getSearchWithFilter(skillId: filterType.id, key: query),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (!snapshot.hasData) {
              // return SearchScreen();
              if (filterType != null)
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 75,
                        decoration: BoxDecoration(
                          color: filters[selectedIndex]['color'],
                          borderRadius: BorderRadius.circular(13),
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        // color: filters[selectedIndex]['color'],
                        child: ListTile(
                          onTap: () {
                            // setFilter(FilterType.Selected, ind);
                            Navigator.of(context).pop();
                          },
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          leading: Text(
                            '${filterType.name}',
                            style: kSearchFilterText,
                          ),
                          trailing: Icon(
                            Icons.filter_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              if (filterType == null)
                return Center(
                  child: Text('No Data'),
                );
            }
            searchResult = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (filterType != null)
                    Card(
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
                          print('pop');
                          return Navigator.of(context).pop();
                        },
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        leading: Text(
                          '${filterType.name}',
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
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, ind) =>
                        buildSearchItem(snapshot.data[ind], context),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void showUser(context, id) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UserProfileScreen(userId: id),
    ),
  );
}

void showCommunity(context, id) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CommunityProfileScreen(uid: id),
    ),
  );
}

Widget buildSearchItem(SearchItem searchResult, BuildContext context) => Card(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      color: Color.fromRGBO(224, 224, 224, 0.88),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListTile(
        onTap: () {
          searchResult.isUser()
              ? showUser(context, searchResult.user.uid)
              : showCommunity(context, searchResult.community.uid);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(searchResult.isUser()
              ? searchResult.user?.image ?? ''
              : searchResult.community?.image ?? ''),
        ),
        title: Text(searchResult.isUser()
            ? searchResult.user.userName
            : '\$${searchResult.community.name}'),
        subtitle: Text(searchResult.isUser() ? searchResult.user?.name : ''),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color.fromRGBO(98, 65, 234, 1),
          size: 25,
        ),
      ),
    );

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

    //Start paint from 35% height to the left
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

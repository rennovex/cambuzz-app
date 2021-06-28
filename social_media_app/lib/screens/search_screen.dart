import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/widgets/app_bar.dart';
import 'package:social_media_app/widgets/search_filters.dart';
import 'package:social_media_app/widgets/search_results.dart';

enum FilterType {
  All,
  Selected,
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _filterType;
  var _selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
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
                CustomAppBar(),
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
                if (_filterType == FilterType.Selected) SearchResults(),
              ],
            ),
          ),
        ),
      )),
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

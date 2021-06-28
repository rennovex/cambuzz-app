import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/http_helper.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/google_sign_in.dart';
import 'package:social_media_app/screens/auth_screen.dart';
import 'package:social_media_app/screens/event_screen.dart';
import 'package:social_media_app/screens/feed_screen.dart';
import 'package:social_media_app/screens/profile_screen.dart';
import 'package:social_media_app/screens/trending_screen.dart';
import 'package:social_media_app/widgets/app_bar.dart';

import 'dummy_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GoogleSignInProvider()),
        ChangeNotifierProvider.value(value: Api()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Color.fromRGBO(229, 229, 229, 1),

          // textTheme: TextTheme(
          //   title: TitleTextStyle,
          //   subtitle: SubtitleTextStyle,
          //   body1: BodyprimaryTextStyle,
          //   body2: BodySecondaryTextStyle,
          // )
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(context);

            if (provider.isSigningIn) {
              return buildLoading();
            } else if (snapshot.hasData) {
              return MyHomePage();
            } else {
              return AuthScreen();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _childern = [
    ProfileScreen(
      profile: profiles[1],
    ),
    FeedScreen(),
    TrendingScreen(),
    EventScreen(events),
  ];

  @override
  void initState() {
    // TODO: implement initState
    HttpHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromRGBO(28, 28, 28, 1),
      //   foregroundColor: Colors.white,
      //   brightness: Brightness.dark,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(18),
      //       bottomRight: Radius.circular(18),
      //     ),
      //   ),
      //   leading: IconButton(
      //     icon: Icon(Icons.search),
      //     onPressed: () {},
      //   ),
      //   actions: [],
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Container(
          child: Icon(
            Icons.add,
            size: 30,
          ),
          width: 60,
          height: 60,
          decoration:
              BoxDecoration(shape: BoxShape.circle, gradient: kLinearGradient),
        ),
        elevation: 2.0,
      ),
      body: _childern.elementAt(_currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedItemColor: kPrimaryColor,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Account'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.trending_up), label: 'Trending'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined), label: 'Events'),
            ],
          ),
        ),
      ),
    );
  }
}

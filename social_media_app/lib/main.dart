import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/secureStorage.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/google_sign_in.dart';
import 'package:social_media_app/screens/AddEventsScreen/add_events_screen.dart';
import 'package:social_media_app/screens/Profiles/community_profile_screen.dart';
import 'package:social_media_app/screens/Profiles/user_profile_screen.dart';
import 'package:social_media_app/screens/auth_screen.dart';
import 'package:social_media_app/screens/blocked_screen.dart';
import 'package:social_media_app/screens/event_screen.dart';
import 'package:social_media_app/screens/FeedScreen/feed_screen.dart';
import 'package:social_media_app/screens/profile_screen.dart';
import 'package:social_media_app/screens/Registration/registration_screen.dart';
import 'package:social_media_app/screens/search_screen.dart';
import 'package:social_media_app/screens/trending_screen.dart';
import 'package:social_media_app/widgets/add_post_modal_sheet.dart';
import 'package:social_media_app/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Global.apiToken = await SecureStorage.readApiToken() ?? '';
  Global.uid = await SecureStorage.readUid() ?? '';
  print(Global.uid);
  print(Global.apiToken);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GoogleSignInProvider()),
        // ChangeNotifierProvider.value(value: Api()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(141, 38, 221, 1),
          backgroundColor: Color.fromRGBO(229, 229, 229, 1),

          // textTheme: TextTheme(
          //   title: TitleTextStyle,
          //   subtitle: SubtitleTextStyle,
          //   body1: BodyprimaryTextStyle,
          //   body2: BodySecondaryTextStyle,
          // )
        ),
        // home:RegistrationScreen()
        // initialRoute: '/',
        routes: {
          // '/': (ctx) => PasswordOverview(),
          CommunityProfileScreen.routeName: (ctx) => CommunityProfileScreen(),
          BlockedScreen.routeName: (ctx) => BlockedScreen(),
          AddEventsScreen.routeName: (ctx) => AddEventsScreen(),
          SearchScreen.routeName: (ctx) => SearchScreen(),
          // UserProfileScreen.routeName: (
          //   ctx,
          // ) =>
          //     UserProfileScreen(
          //       userId: id,
          //     ),
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(context);

            if (provider.isSigningIn) {
              return buildLoading();
            } else if (snapshot.hasData) {
              return MyHomePage();
            } else {
              return RegistrationScreen(false);
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
  int _selectedPageIndex;
  PageController _pageController;
  List<Widget> _pages;
  bool registrationJustCompleted = false;
  var user;

  void initializePages() {
    _pages = [
      FeedScreen(user),
      SearchScreen(),
      TrendingScreen(user),
      EventScreen(user),
    ];
  }

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 0;

    initializePages();

    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  // Future init() async {
  //   final uid = await SecureStorage.readUid();
  //   Global.uid = uid;
  //   print(Global().uid);
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Api.getUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              child: SpinKitCircle(
                color: kPrimaryColor,
              ),
            );
          if (snapshot.data == null && !registrationJustCompleted)
            return RegistrationScreen(true, email: '',
                onRegistrationComplete: () {
              setState(() {
                registrationJustCompleted = true;
              });
            });
          user = snapshot.data;
          initializePages();
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () => showModalBottomSheet<dynamic>(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => AddPost(context),
                ),
                tooltip: 'Increment',
                child: Container(
                  child: Icon(
                    Icons.add,
                    size: 30,
                  ),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, gradient: kLinearGradient),
                ),
                elevation: 2.0,
              ),
              body: PageView(
                controller: _pageController,
                children: _pages,
                physics: NeverScrollableScrollPhysics(),
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
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
                    currentIndex: _selectedPageIndex,
                    onTap: (index) {
                      setState(() {
                        _selectedPageIndex = index;
                        _pageController.jumpToPage(index);
                      });
                    },
                    selectedItemColor: kPrimaryColor,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Feed'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.search), label: 'Search'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.trending_up), label: 'Trending'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.calendar_today_outlined),
                          label: 'Events'),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

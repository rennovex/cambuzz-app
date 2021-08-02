import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/secureStorage.dart';
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
import 'package:social_media_app/screens/trending_screen.dart';
import 'package:social_media_app/widgets/add_post_modal_sheet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Global.apiToken = await SecureStorage.readApiToken() ?? '';
  Global.uid = await SecureStorage.readUid() ?? '';

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
              // print(snapshot.data);
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
  int _selectedPageIndex;
  PageController _pageController;
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 0;

    _pages = [
      FeedScreen(),
      UserProfileScreen(),
      TrendingScreen(),
      EventScreen(),
    ];

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
    return SafeArea(
      child: Scaffold(
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
        //     icon: CircleAvatar(
        //       backgroundImage: NetworkImage(
        //         'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1868&q=80',
        //       ),
        //       radius: 19,
        //     ),
        //     onPressed: () {},
        //   ),
        //   title: Text('CamBuzz'),
        //   centerTitle: true,
        //   actions: [
        //     IconButton(
        //       icon: Icon(Icons.near_me),
        //       onPressed: () {},
        //     )
        //   ],
        // ),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              currentIndex: _selectedPageIndex,
              onTap: (index) {
                setState(() {
                  _selectedPageIndex = index;
                  _pageController.jumpToPage(index);
                });
              },
              selectedItemColor: kPrimaryColor,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: 'Account'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.trending_up), label: 'Trending'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today_outlined), label: 'Events'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

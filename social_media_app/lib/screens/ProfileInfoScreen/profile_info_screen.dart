import 'package:flutter/material.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/screens/ProfileInfoScreen/profile_info_arguments.dart';
import 'package:social_media_app/widgets/info_tile.dart';

class ProfileInfoScreen extends StatefulWidget {
  static const routeName = '/profile/profileInfo';
  final String title;
  final String id;
  const ProfileInfoScreen({this.id, this.title, Key key}) : super(key: key);

  @override
  _ProfileInfoScreenState createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  Future future;
  ProfileInfoArguments args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context).settings.arguments as ProfileInfoArguments;

    future = args.title == 'Followers'
        ? Api.getFollowers(args.id)
        : args.title == 'Following'
            ? Api.getFollowing(args.id)
            : Api.getFollowing(args.id);

    // Api.getMembers(args.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: FutureBuilder(
          future: future,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, ind) => InfoTile(
                        info: snapshot.data[ind],
                      ));
            } else
              return Center(
                child: Text('No ${args.title}'),
              );
          }),
    );
  }
}

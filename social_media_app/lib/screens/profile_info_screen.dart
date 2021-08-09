import 'package:flutter/material.dart';
import 'package:social_media_app/providers/api.dart';
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

  @override
  void initState() {
    super.initState();
    future = widget.title == 'Followers'
        ? Api.getFollowers(widget.id)
        : Api.getFollowing(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                child: Text('No + ${widget.title}'),
              );
          }),
    );
  }
}

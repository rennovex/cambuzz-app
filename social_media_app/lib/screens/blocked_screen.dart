import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/api.dart';

class BlockedScreen extends StatefulWidget {
  static const routeName = '/userBlockedScreen';
  const BlockedScreen({Key key}) : super(key: key);

  @override
  _BlockedScreenState createState() => _BlockedScreenState();
}

class _BlockedScreenState extends State<BlockedScreen> {
  Future<List<User>> future;

  @override
  void initState() {
    super.initState();
    future = Api.getBlocked();
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<User>> future = Api.getBlocked();
    return Scaffold(
      appBar: AppBar(
        title: Text('Blocked'),
      ),
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (!snapshot.hasData) {
            return Center(
              child: Text('No accounts blocked'),
            );
          } else {
            print(snapshot.data);
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (_, ind) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data[ind].image ?? ''),
                      ),
                      title: Text(snapshot.data[ind].userName),
                      trailing: TextButton(
                        onPressed: () {
                          Api.unBlock(snapshot.data[ind].uid);
                          setState(() {
                            Fluttertoast.showToast(
                                msg:
                                    '${snapshot.data[ind].userName} unblocked');
                            snapshot.data.removeAt(ind);
                          });
                        },
                        child: Text('unblock'),
                      ),
                    ));
          }
        },
      ),
    );
  }
}

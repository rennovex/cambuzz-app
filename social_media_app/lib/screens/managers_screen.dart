import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/api.dart';

class ManagersScreen extends StatefulWidget {
  static const routeName = '/managersScreen';
  const ManagersScreen({Key key}) : super(key: key);

  @override
  _ManagersScreenState createState() => _ManagersScreenState();
}

class _ManagersScreenState extends State<ManagersScreen> {
  Future<List<User>> future;

  @override
  void initState() {
    super.initState();
    future = Api.getManagers();
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<User>> future = Api.getBlocked();
    return Scaffold(
      appBar: AppBar(
        title: Text('Managers'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () async {
              var res = await showSearch(
                  context: context, delegate: CustomManagerSearchDelegate());

              if (res == true) {
                setState(() {
                  future = Api.getManagers();
                });
              }
            },
          ),
        ],
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
              child: Text('No Managers'),
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
                          Api.removeManager(snapshot.data[ind].uid);
                          setState(() {
                            Fluttertoast.showToast(
                                msg: '${snapshot.data[ind].userName} removed');
                            snapshot.data.removeAt(ind);
                          });
                        },
                        child: Text(
                          'remove',
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      ),
                    ));
          }
        },
      ),
    );
  }
}

class CustomManagerSearchDelegate extends SearchDelegate {
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
          backgroundImage: NetworkImage(searchResult[ind]['image'] ?? ''),
        ),
        onTap: () => close(context, searchResult[ind]),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: Api.getUserSearch(key: query),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return Center(child: Text('Add managers'));
        searchResult = snapshot.data;
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (_, ind) => ListTile(
            title: Text(snapshot.data[ind]['name']),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data[ind]['image'] ?? ''),
            ),
            // onTap: () => close(context, snapshot.data[ind]),
            trailing: TextButton(
              child: Text(
                'add',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () async {
                Fluttertoast.showToast(msg: 'Adding manager ...');
                await Api.addManager(snapshot.data[ind]['_id']);

                close(context, true);
              },
            ),
          ),
        );
      },
    );
  }
}

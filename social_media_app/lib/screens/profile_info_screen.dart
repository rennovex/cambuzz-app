import 'package:flutter/material.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (_, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting)
        return Center(child: CircularProgressIndicator(),);
        else if(snapshot.hasData){
          return ListView.builder(itemBuilder: (_,ind) => )
        }
    });
  }
}

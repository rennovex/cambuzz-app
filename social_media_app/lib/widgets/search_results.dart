import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (ctx, ind) => Card(
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          color: Color.fromRGBO(224, 224, 224, 0.88),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: CircleAvatar(
              radius: 28,
            ),
            title: Text('Ashfin Nannase'),
            subtitle: Text('Ashfin Nannase'),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color.fromRGBO(98, 65, 234, 1),
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}

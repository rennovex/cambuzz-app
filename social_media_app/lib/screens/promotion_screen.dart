import 'package:flutter/material.dart';

class PromotionScreen extends StatelessWidget {
  const PromotionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ListTile(
              leading: CircleAvatar(),
              title: Text('Ashfin Nannase'),
              subtitle: Text('Photography'),
              trailing: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
            ClipRRect(),
            Column(children: [
              Container(
                // margin: EdgeInsets.all(value),
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text('View Event'),
                ),
              ),
              OutlinedButton(
                onPressed: () {},
              ),
              OutlinedButton(
                onPressed: () {},
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

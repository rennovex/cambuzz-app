import 'package:flutter/material.dart';

class TransparentAppbar extends StatelessWidget with PreferredSizeWidget {
  const TransparentAppbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: true,
      // elevation: ,
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}

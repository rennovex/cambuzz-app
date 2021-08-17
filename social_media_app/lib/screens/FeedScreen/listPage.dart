import 'package:flutter/foundation.dart';

class ListPage<ItemType> {
  final List<ItemType> itemList;

  ListPage({
    @required this.itemList,
  }) : assert(itemList != null);

  bool get isLastPage => itemList.isEmpty;
}

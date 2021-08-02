import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/widgets/post_item.dart';

class PagedFeedListView extends StatefulWidget {
  const PagedFeedListView({Key key}) : super(key: key);

  @override
  _PagedFeedListViewState createState() => _PagedFeedListViewState();
}

class _PagedFeedListViewState extends State<PagedFeedListView> {
  final _pagingController = PagingController<int, Post>(
    firstPageKey: 1,
  );

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newPage = await Api.getFeedByPage(pageKey);
      // final nextPageKey = pageKey + 1;
      // final newItems = newPage.itemList;
      // _pagingController.appendPage(newItems, nextPageKey);
      //   _pagingController.appendPage(newItems, nextPageKey);
      // print(newPage);
      // final previouslyFetchedItemsCount =
      //     // 2
      //     _pagingController.itemList?.length ?? 0;

      // print(_pagingController.itemList);
      // print(previouslyFetchedItemsCount);

      final isLastPage = newPage.isLastPage;
      // final isLastPage = false;
      final newItems = newPage.itemList;

      if (isLastPage) {
        // 3
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      // 4
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => _pagingController.refresh(),
      ),
      child: PagedListView(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Post>(
          itemBuilder: (context, post, index) => ChangeNotifierProvider.value(
            value: post,
            child: PostItem(),
          ),
          firstPageErrorIndicatorBuilder: (context) => Center(
            child: Text('FirstPageError'),
          ),
          noItemsFoundIndicatorBuilder: (context) => Center(
            child: Text('NoItemsFoundIndicator'),
          ),
        ),
      ),
    );
  }
}

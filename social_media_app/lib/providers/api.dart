import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/models/event.dart';

import 'package:social_media_app/models/http_helper.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/models/user.dart';

class Api {
  static Future feedRefresh() async {
    print('refresh');
  }

  // Get Feed from Api
  static Future getFeed() async {
    final response = await HttpHelper().getApi('/feed');

    if (response.statusCode != 200) {
      throw response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List<Post> posts = [];

    json.forEach((post) {
      return posts.add(Post.fromJson(post));
    });
    print('Fetched Feed from Api');

    return posts;
  }

  //Get User from Api
  static Future<User> getUser() async {
    final response = await HttpHelper().getApi('/users');

    if (response.statusCode != 200) {
      throw response.body;
    }

    final json = jsonDecode(response.body);
    User user = User.fromJson(json);
    return user;
  }

  //Get Events from Api
  static Future<List<Event>> getEvents() async {
    final response = await HttpHelper().getApi('/events/all');

    if (response.statusCode != 200) {
      throw 'Events not fetched' + response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List<Event> events = [];

    json.forEach((e) {
      events.add(Event.fromJson(e));
    });
    print('Fetched events from API');

    return events;
  }

  //Get Community Trending post from Api
  static Future<List<Post>> getTrendingCommunityPosts() async {
    final response = await HttpHelper().getApi('/trending/community-posts/all');

    if (response.statusCode != 200) {
      print('error');
      throw response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List<Post> posts = [];

    json.forEach((post) {
      return posts.add(Post.fromJson(post));
    });

    print('Fetched Community trending from Api');

    return posts;
  }

  //Get user Trending post from Api
  static Future<List<Post>> getTrendingUserPosts() async {
    final response = await HttpHelper().getApi('/trending/user-posts/all');

    if (response.statusCode != 200) {
      print('error');
      throw response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List<Post> posts = [];

    json.forEach((post) {
      print(post);
      return posts.add(Post.fromJson(post));
    });

    print('Fetched User trending from Api');

    return posts;
  }

  // Post comments to APi
  static Future postcomment({String id, String comment}) async {
    final response = await HttpHelper()
        .post(uri: '/posts/comments/$id', body: {"commentText": "$comment"});

    if (response.statusCode != 200) {
      throw 'Not Commented ' + response.body;
    }
  }

  static Future getCommunitySearch({String key}) async {
    final response = await HttpHelper().getApi('/communities/search/$key');
    if (response.statusCode != 200) {
      throw 'Not Commented ' + response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List searchResults = [];

    json.forEach((result) {
      return searchResults.add(result);
    });

    print('Fetched Search results from Api');

    return searchResults;
  }

  static Future postCommunityTextPost(
      {String id, String title, String text}) async {
    final response = await HttpHelper().post(
        uri: '/posts/community/$id/text',
        body: {"title": "$title", "postText": "$text"});

    if (response.statusCode != 201) {
      throw 'Not posted ' + response.body;
    }
  }

  static Future postCommunityImagePost(
      {String id, XFile image, String title}) async {
    final apiResponse = await HttpHelper().post(
        uri: '/posts/community/$id/image',
        body: {"title": "$title", "fileType": ".jpeg"});

    if (apiResponse.statusCode != 201) {
      throw 'Not posted ' + apiResponse.body;
    }

    final awsUploadLink = jsonDecode(apiResponse.body)['imageUploadUrl'];

    final awsResponse =
        await HttpHelper().put(uri: '$awsUploadLink', body: image);

    if (awsResponse.statusCode != 200) {
      throw 'Not posted ' + awsResponse.body;
    }

    print('image is posted' + awsResponse.body);
  }

  static Future postUserImagePost(
      {String id, XFile image, String title}) async {
    final apiResponse = await HttpHelper().post(
        uri: '/posts/user/image',
        body: {"title": "$title", "fileType": ".jpeg"});

    if (apiResponse.statusCode != 201) {
      throw 'Not posted ' + apiResponse.body;
    }

    final awsUploadLink = jsonDecode(apiResponse.body)['imageUploadUrl'];

    final awsResponse =
        await HttpHelper().put(uri: '$awsUploadLink', body: image);

    if (awsResponse.statusCode != 200) {
      throw 'Not posted ' + awsResponse.body;
    }
    print('image is posted' + awsResponse.body);
  }

  static Future postUserTextPost({String title, String text}) async {
    final response = await HttpHelper().post(
        uri: '/posts/user/text',
        body: {"title": "$title", "postText": "$text"});

    if (response.statusCode != 201) {
      throw 'Not posted ' + response.body;
    }
  }
}

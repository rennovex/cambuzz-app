import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/models/event.dart';
import 'package:social_media_app/models/eventType.dart';

import 'package:social_media_app/models/http_helper.dart';
import 'package:social_media_app/models/searchItem.dart';
import 'package:social_media_app/models/skill.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/screens/FeedScreen/listPage.dart';

class Api {
  static Future<ListPage<Post>> getFeedByPage(int page) async {
    final response = await HttpHelper.get('/feed/$page');

    if (response.statusCode != 200) {
      throw response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List<Post> posts = [];

    json.forEach((post) {
      return posts.add(Post.fromJson(post));
    });
    print('Fetched page $page  from Api');

    return ListPage(itemList: posts);
  }

  static Future postCommunity(String communityName, XFile image) async {
    final response = await HttpHelper.post(
        uri: '/communities', body: {'name': communityName, 'fileType': '.jpg'});
    if (response.statusCode == 201) {
      if (image != null) {
        final awsUploadLink = jsonDecode(response.body)['imageUploadUrl'];

        final awsResponse =
            await HttpHelper.putImage(uri: '$awsUploadLink', body: image);

        if (awsResponse.statusCode != 200) {
          throw 'Community could not be created due to image upload error  ' +
              awsResponse.body;
        }
        print('Community is created' + awsResponse.body);
      }

      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  static Future putCommunity(String communityName, XFile image) async {
    final response = await HttpHelper.put(
        uri: '/communities', body: {'name': communityName, 'fileType': '.jpg'});
    if (response.statusCode == 200) {
      if (image != null) {
        final awsUploadLink = jsonDecode(response.body)['imageUploadUrl'];

        final awsResponse =
            await HttpHelper.putImage(uri: '$awsUploadLink', body: image);

        if (awsResponse.statusCode != 200) {
          throw 'Community could not be modified due to image upload error  ' +
              awsResponse.body;
        }
        print('Community is modified' + awsResponse.body);
      }

      return true;
    } else {
      print(response.body);
      return false;
    }
  }

   static Future putCommunityWithoutImage(String communityName) async {
     print('put request to community without image');
    final response = await HttpHelper.put(
        uri: '/communities/without-image', body: {'name': communityName, 'fileType': '.jpg'});
    print('got response');
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  

  static Future isUserRegistered(String email) async {
    final response = await HttpHelper.get('/auth/is-user-registered/' + email);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      return false;
    } else {
      throw "User registered cannot be retrieved from server";
    }
  }

  static Future postUser(User user, String firebaseUid, XFile image) async {
    final response = await HttpHelper.post(uri: '/auth/register', body: {
      'name': user.name,
      'email': user.email,
      'userName': user.userName,
      'bio': user.bio ?? '',
      'uid': firebaseUid,
      'skills': user.skills ?? [],
      'fileType': '.jpg'
    });
    if (response.statusCode == 201) {
      if (image != null) {
        final awsUploadLink = jsonDecode(response.body)['imageUploadUrl'];

        final awsResponse =
            await HttpHelper.putImage(uri: '$awsUploadLink', body: image);

        if (awsResponse.statusCode != 200) {
          throw 'User could not be created due to image upload error  ' +
              awsResponse.body;
        }
        print('User is created' + awsResponse.body);
      }

      return {
        'status': true,
        'uid': firebaseUid,
        '_id': jsonDecode(response.body)['_id'],
        'token': response.headers['x-auth-token']
      };
    } else {
      print('user is not created due to' + response.body);
      return {'status':false};
    }
  }

  static Future getSkills() async {
    final response = await HttpHelper.get('/skills');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;

      final List skills = [];

      json.forEach((skill) {
        skills.add(Skill.fromJson(skill));
      });
      return skills;
    } else {
      throw 'error could not get skills';
    }
  }

  static Future isCommunityNameAvailable(String name) async {
    final response =
        await HttpHelper.get('/communities/name-available/' + name);
    if (response.statusCode == 409) {
      return false;
    } else if (response.statusCode == 200) {
      return true;
    } else
      throw 'error username availability cannot be checked';
  }

  static Future<bool> isUsernameAvailable(String userName) async {
    final response =
        await HttpHelper.get('/users/username-available/' + userName);
    if (response.statusCode == 409) {
      return false;
    } else if (response.statusCode == 200) {
      return true;
    } else
      throw 'error username availability cannot be checked';
  }

  // Get Feed from Api
  static Future getFeed() async {
    final response = await HttpHelper.get('/feed');

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

  static Future login(String email, String uid) async {
    final response = await HttpHelper.post(uri: '/auth/login', body: {
      'email': email,
      'uid': uid,
    });

    print(response.body + response.statusCode.toString() + email + uid);

    if (response.statusCode == 200) {
      User user = User.fromJsonAbstract(jsonDecode(response.body));
      return {
        'status': true,
        'token': response.headers['x-auth-token'],
        'user': user
      };
    } else {
      return {'status': false};
    }
  }

  //Get User from Api
  static Future<User> getUser() async {
    print('tring to get user');
    final response = await HttpHelper.get('/users');
    print('response');
    print('response from get user' +
        response.body +
        response.statusCode.toString());

    if (response.statusCode == 401) {
      print('401 error');
      throw '401';
    } else if (response.statusCode == 404) {
      print('404 error');
      throw '404';
    } else if (response.statusCode != 200) {
      print('some error with user' +
          response.statusCode.toString() +
          response.body);
      throw '-1';
    } else {
      final json = jsonDecode(response.body);
      User user = User.fromJsonMyProfile(json);
      return user;
    }
  }

  static Future<Map> putUser(User user, XFile image) async {
    final response = await HttpHelper.put(uri: '/users', body: {
      'name': user.name,
      'email': user.email,
      'userName': user.userName,
      'bio': user.bio ?? '',
      'skills': user.skills ?? [],
      'fileType': '.jpg'
    });
    if (response.statusCode == 200) {
      if (image != null) {
        final awsUploadLink = jsonDecode(response.body)['imageUploadUrl'];

        final awsResponse =
            await HttpHelper.putImage(uri: '$awsUploadLink', body: image);

        if (awsResponse.statusCode != 200) {
          throw 'User could not be created due to image upload error  ' +
              awsResponse.body;
        }
        print('User is created' + awsResponse.body);
      }
      return {'status':true, 'user':User.fromJsonAbstract(jsonDecode(response.body))};
    } else {
      print('user is not created due to' + response.body);
      return {'status':false};
    }
  }

  static Future<Map> putUserWithoutImage(User user) async {
    final response = await HttpHelper.put(uri: '/users/without-image', body: {
      'name': user.name,
      'email': user.email,
      'userName': user.userName,
      'bio': user.bio ?? '',
      'skills': user.skills ?? [],
      'fileType': '.jpg'
    });
    if (response.statusCode == 200) {
      return {'status':true,'user':User.fromJsonAbstract(jsonDecode(response.body))};
    } else {
      print('user is not created due to' + response.body);
      return {'status':false};
    }
  }

  static Future<User> getUserWithId(String userId) async {
    final response = await HttpHelper.get('/users/$userId');

    if (response.statusCode != 200) {
      throw response.body;
    }

    final json = jsonDecode(response.body);
    User user = User.fromJson(json);
    return user;
  }

  //Get community from Api
  static Future<Community> getCommunity() async {
    final response = await HttpHelper.get('/communities');

    if (response.statusCode != 200) {
      throw response.body;
    }
    final json = jsonDecode(response.body) as Map;

    Community community = Community.fromJson(json);
    // print(community.name);
    return community;
  }

  static Future<Community> getCommunityWithId(String id) async {
    final response = await HttpHelper.get('/communities/$id');

    if (response.statusCode != 200) {
      throw response.body;
    }
    final json = jsonDecode(response.body) as Map;

    Community community = Community.fromJson(json);
    return community;
  }

  //Get Events from Api
  static Future<List<Event>> getEvents() async {
    final response = await HttpHelper.get('/events/all');

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

  static Future<List<Event>> getEventsWithFilterId(String id) async {
    final response = await HttpHelper.get('/events/all/filter/$id');

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

  static Future getEventTypes() async {
    final response = await HttpHelper.get('/event-types');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;

      final List<EventType> eventTypes = [];

      json.forEach((eventType) {
        eventTypes.add(EventType.fromJson(eventType));
      });
      return eventTypes;
    } else {
      throw 'error could not get skills';
    }
  }

  static Future postEvent({
    String title,
    XFile image,
    String time,
    String descritpion,
    String contact,
    String link,
    String eventType,
  }) async {
    final apiResponse = await HttpHelper.post(uri: '/events', body: {
      "fileType": ".jpeg",
      "title": "$title",
      "time": "$time",
      "description": "$descritpion",
      "contact": "$contact",
      "link": "$link",
      "eventType": "$eventType"
    });

    if (apiResponse.statusCode != 201) {
      throw 'Not posted ' + apiResponse.body;
    }

    final awsUploadLink = jsonDecode(apiResponse.body)['imageUploadUrl'];

    final awsResponse =
        await HttpHelper.putImage(uri: '$awsUploadLink', body: image);

    if (awsResponse.statusCode != 200) {
      throw 'Not posted ' + awsResponse.body;
    }
    print('image is posted' + awsResponse.body);
    Fluttertoast.showToast(msg: 'Event posted');
  }

  //Get Community Trending post from Api
  static Future<List<Post>> getTrendingCommunityPosts() async {
    final response = await HttpHelper.get('/trending/community-posts/all');

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
    final response = await HttpHelper.get('/trending/user-posts/all');

    if (response.statusCode != 200) {
      print('error ' + response.body);
      throw response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List<Post> posts = [];

    json.forEach((post) {
      return posts.add(Post.fromJson(post));
    });

    print('Fetched User trending from Api');

    return posts;
  }

  // Post comments to APi
  static Future postcomment({String id, String comment}) async {
    final response = await HttpHelper.post(
        uri: '/posts/comments/$id', body: {"commentText": "$comment"});

    if (response.statusCode != 200) {
      throw 'Not Commented ' + response.body;
    }
  }

  static Future getCommunitySearch({String key}) async {
    final response = await HttpHelper.get('/communities/search/$key');
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
    final response = await HttpHelper.post(
        uri: '/posts/community/$id/text',
        body: {"title": "$title", "postText": "$text"});

    if (response.statusCode != 201) {
      throw 'Not posted ' + response.body;
    }
  }

  static Future postCommunityImagePost(
      {String id, XFile image, String title}) async {
    final apiResponse = await HttpHelper.post(
        uri: '/posts/community/$id/image',
        body: {"title": "$title", "fileType": ".jpeg"});

    if (apiResponse.statusCode != 201) {
      throw 'Not posted ' + apiResponse.body;
    }

    final awsUploadLink = jsonDecode(apiResponse.body)['imageUploadUrl'];

    final awsResponse =
        await HttpHelper.putImage(uri: '$awsUploadLink', body: image);

    if (awsResponse.statusCode != 200) {
      throw 'Not posted ' + awsResponse.body;
    }

    print('image is posted' + awsResponse.body);
  }

  static Future postUserImagePost(
      {String id, XFile image, String title}) async {
    final apiResponse = await HttpHelper.post(
        uri: '/posts/user/image',
        body: {"title": "$title", "fileType": ".jpeg"});

    if (apiResponse.statusCode != 201) {
      throw 'Not posted ' + apiResponse.body;
    }

    final awsUploadLink = jsonDecode(apiResponse.body)['imageUploadUrl'];

    final awsResponse =
        await HttpHelper.putImage(uri: '$awsUploadLink', body: image);

    if (awsResponse.statusCode != 200) {
      throw 'Not posted ' + awsResponse.body;
    }
    print('image is posted' + awsResponse.body);
  }

  static Future postUserTextPost({String title, String text}) async {
    final response = await HttpHelper.post(
        uri: '/posts/user/text',
        body: {"title": "$title", "postText": "$text"});

    if (response.statusCode != 201) {
      throw 'Not posted ' + response.body;
    }
  }

  static Future<List<User>> getBlocked() async {
    final response = await HttpHelper.get('/users/blocked');

    if (response.statusCode != 200) {
      throw 'Events not fetched' + response.body;
    }

    final json = jsonDecode(response.body) as List;

    if (json.isEmpty) {
      print('No Accounts Blocked');
      return null;
    }

    final List<User> blocked = [];

    json.forEach((e) {
      blocked.add(User.fromJsonAbstract(e));
    });
    print('Fetched blocked from API');
    print(blocked);

    return blocked;
  }

  static Future unBlock(String id) async {
    final response = await HttpHelper.delete(
      uri: '/users/block/$id',
      body: {},
    );

    if (response.statusCode != 200) {
      Fluttertoast.showToast(msg: 'Couldn\'t unblock !');
      throw 'Could not unblock' + response.body;
    }
  }

  static Future block(String id) async {
    final response = await HttpHelper.post(
      uri: '/users/block/$id',
      body: {},
    );

    if (response.statusCode != 200) {
      Fluttertoast.showToast(msg: 'Couldn\'t block !');
      throw 'Could not block' + response.body;
    }
  }

  static Future getSearch({String key}) async {
    final response = await HttpHelper.get('/search/$key');
    if (response.statusCode != 200) {
      throw 'Not Commented ' + response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List searchResults = [];

    json.forEach((result) {
      // if (result.containsKey('userName'))
      //   return searchResults.add(User.fromJson(result));
      // else
      //   return searchResults.add(Community.fromJson(result));
      // print(SearchItem.fromJson(result).profileType);
      // print(SearchItem.fromJson(result).user.name);
      return searchResults.add(SearchItem.fromJson(result));
    });

    print('Fetched Search results from Api');

    return searchResults;
  }

  static Future getSearchWithFilter({String skillId, String key}) async {
    final response = await HttpHelper.get('/search/filter/id/$skillId/$key');
    if (response.statusCode != 200) {
      throw 'Not Commented ' + response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List searchResults = [];

    json.forEach((result) {
      // if (result.containsKey('userName'))
      //   return searchResults.add(User.fromJson(result));
      // else
      //   return searchResults.add(Community.fromJson(result));

      return searchResults.add(SearchItem.fromJson(result));
    });

    print('Fetched Search results from Api');

    return searchResults;
  }

  static Future getFollowers(String id) async {
    final response = await HttpHelper.get('/users/$id/followers');

    if (response.statusCode != 200) {
      throw 'followers not fetched' + response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List followers = [];

    json.forEach((user) {
      followers.add(User.fromJsonAbstract(user));
    });
    print('Fetched followers from API');

    return followers;
  }

  static Future getFollowing(String id) async {
    final response = await HttpHelper.get('/users/$id/following');

    if (response.statusCode != 200) {
      throw 'following not fetched' + response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List following = [];

    json.forEach((user) {
      following.add(User.fromJsonAbstract(user));
    });
    print('Fetched following from API');

    return following;
  }

  static Future<List<User>> getManagers() async {
    final response = await HttpHelper.get('/communities/managers');

    if (response.statusCode != 200) {
      throw 'Managers not fetched' + response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List<User> managers = [];

    json.forEach((e) {
      managers.add(User.fromJsonAbstract(e));
    });
    print('Fetched managers from API');
    print(managers);

    return managers;
  }

  static Future removeManager(String id) async {
    final response = await HttpHelper.delete(
      uri: '/communities/managers/$id',
      body: {},
    );

    if (response.statusCode != 200) {
      Fluttertoast.showToast(msg: 'Couldn\'t remove manager !');
      throw 'Could not remove manager' + response.body;
    }
  }

  static Future addManager(String id) async {
    final response = await HttpHelper.post(
      uri: '/communities/managers/$id',
      body: {},
    );

    if (response.statusCode != 200) {
      Fluttertoast.showToast(msg: 'Couldn\'t add manager !');
      throw 'Could not add manager' + response.body;
    }
  }

  static Future getUserSearch({String key}) async {
    final response = await HttpHelper.get('/users/search/$key');
    if (response.statusCode != 200) {
      throw 'Could not search users ' + response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List searchResults = [];

    json.forEach((result) {
      return searchResults.add(result);
    });

    print('Fetched Search results from Api');

    return searchResults;
  }

  static Future postReport({String id, String objectType}) async {
    final response = await HttpHelper.post(
        uri: '/report', body: {"objectType": "$objectType", "objectId": "$id"});

    if (response.statusCode != 201) {
      throw 'Not reported ' + response.body;
    }
  }
}

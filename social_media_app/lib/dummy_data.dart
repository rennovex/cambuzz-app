import 'models/post.dart';
import 'models/profile.dart';

final List<Profile> profiles = [
  Profile(
    profileType: ProfileType.CommunityProfile,
    profileName: '\$Memes',
    profileImg:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGbK61tJDp2gLVTuG_Tvsk3waIoGgpmv4z7Q&usqp=CAU',
    profileCoverImg:
        'https://aesthetic-god-74.webself.net/file/si1601206/jamie-matocinos-WAYY2WoGb8w-unsplash-fi24475771x400.jpg',
    profileBio:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
    events: 3,
    followers: 100,
    members: 69,
  ),
];

final List<Post> feed = [
  Post(
    postImg: 'https://picsum.photos/id/237/200/300',
    profileImg:
        'https://i.pinimg.com/236x/b7/1c/5f/b71c5f377615229c2d23c79686400eff.jpg',
    title:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    profileName: 'The Hangout',
    userName: 'shaquille.oatmeal',
    time: '',
    postType: PostType.ImagePost,
  ),
  Post(
    postImg:
        'https://i.pinimg.com/236x/c5/f4/dc/c5f4dc041aaa2ccfdead0d9a26638003.jpg',
    profileImg:
        'https://i.pinimg.com/236x/d1/0a/fc/d10afcd6295a85852ea189d611e152ac.jpg',
    title: 'It is a long established fact that a reader will be',
    profileName: 'The Java Room',
    userName: 'hanging_gnomies',
    time: '',
    postType: PostType.ImagePost,
  ),
  Post(
    postImg:
        'https://i.pinimg.com/236x/3d/17/e7/3d17e7af25951b9fd988ca292fc4b45f.jpg',
    profileImg:
        'https://i.pinimg.com/236x/96/4d/50/964d50b13ddb8011ae44f9fc2521866a.jpg',
    title: 'Contrary to popular belief, Lorem Ipsum is not simply random text.',
    profileName: 'Communion',
    userName: 'hoosier-daddy',
    time: '',
    postType: PostType.ImagePost,
  ),
  Post(
    postImg:
        'https://i.pinimg.com/236x/0c/17/ca/0c17ca0e82e873d6b0bd5a44790c7813.jpg',
    profileImg:
        'https://i.pinimg.com/236x/c8/c3/0f/c8c30f07d1084ca16a74f3a1757d7b26.jpg',
    title: 'There are many variations of passages of Lorem Ipsum available,',
    profileName: 'The Art Base',
    userName: 'BadKarma',
    time: '',
    postType: PostType.ImagePost,
  ),
  Post(
    postImg:
        'https://i.pinimg.com/236x/0c/17/ca/0c17ca0e82e873d6b0bd5a44790c7813.jpg',
    profileImg:
        'https://i.pinimg.com/236x/c8/c3/0f/c8c30f07d1084ca16a74f3a1757d7b26.jpg',
    title: 'There are many variations of passages of Lorem Ipsum available,',
    profileName: 'The Art Base',
    userName: 'BadKarma',
    time: '',
    postType: PostType.TextPost,
    postText:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
  ),
];

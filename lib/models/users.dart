import 'package:instagram/utils/keys.dart';

class User {
  final String uid;
  final String fullName;
  final String birthday;
  final String gender;
  final String ? bio;
  final String profileImageUrl;
  final String username;
  final String emailAddress;
  final List followers;
  final List following;

  User({
    required this.uid,
    required this.fullName,
    required this.birthday,
    required this.gender,
    required this.bio,
    required this.profileImageUrl,
    required this.username,
    required this.emailAddress,
    required this.followers,
    required this.following
  });

  Map<String,dynamic> toJson() => {
    uidKey : uid,
    fullNameKey : fullName,
    birthdayKey : birthday,
    genderKey : gender,
    bioKey : bio,
    profileImageUrlKey : profileImageUrl,
    usernameKey : username,
    emailAddressKey : emailAddress,
    followersKey : followers,
    followingKey : following
  };
}
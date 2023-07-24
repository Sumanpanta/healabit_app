import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseUser {
  final String userID;
  final String firstName;
  final String email;
  final String profilePictureURL;

  FireBaseUser({
    required this.userID,
    required this.firstName,
    required this.email,
    required this.profilePictureURL,
  });

  Future<String?>? get uid => null;

  Map<String, Object> toJson() {
    return {
      'userID': userID,
      'firstName': firstName,
      'email': email == null ? '' : email,
      'profilePictureURL': profilePictureURL,
      'appIdentifier': 'flutter-onboarding'
    };
  }

  factory FireBaseUser.fromJson(Map<String, dynamic> doc) {     //,param1 removed if any error occure, try fixing it 
    return FireBaseUser(
      userID: doc['userID'] as String,
      firstName: doc['firstName'] as String,
      email: doc['email'] as String,
      profilePictureURL: doc['profilePictureURL'] as String,
    );
  }

  factory FireBaseUser.fromDocument(DocumentSnapshot doc) {
    return FireBaseUser.fromJson(doc.data() as Map<String, dynamic>);
  }
}

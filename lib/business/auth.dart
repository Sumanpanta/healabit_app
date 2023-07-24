import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healabit_app/models/user.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }

class Auth {
  static Future<String?> signIn(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    FireBaseUser user = userCredential.user as FireBaseUser ;  //changed here
    return user.uid;
  }

  static Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<String?> signUp(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FireBaseUser user = userCredential.user as FireBaseUser;    //changed here 

    String username = "healabit@gmail.com";
    String emailPass = "healabit";

    final smtpServer = gmail(username, emailPass); 
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add('healabit@gmail.com') //recipient email
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipients emails
      // ..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipients emails
      ..subject = 'Welcome :: 😀 :: ${DateTime.now()}' //subject of the email
      ..text = 'Welcome to Healabit'; //body of the email

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n'+ e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
    return user.uid;
  }

  static Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
  }

  static Future<User?> getCurrentFirebaseUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  static void addUser(FireBaseUser user) async {
    checkUserExist(user.userID).then((value) {
      if (!value) {
        print("user ${user.firstName} ${user.email} added");
        FirebaseFirestore.instance
            .doc("users/${user.userID}")
            .set(user.toJson());
      } else {
        print("user ${user.firstName} ${user.email} exists");
      }
    });
  }

  static Future<bool> checkUserExist(String userID) async {
    bool exists = false;
    try {
      await FirebaseFirestore.instance.doc("users/$userID").get().then((doc) {   //used firebasefirestore as latest
        exists = doc.exists;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }
  
  static Stream<FireBaseUser?> getUser(String userID) {   //changed here 
    return FirebaseFirestore.instance
        .collection("users")
        .where("userID", isEqualTo: userID)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return FireBaseUser.fromDocument(snapshot.docs.first);
      } else {
        return null;
      }
    });
  }

  static String getExceptionText(Exception e, Object f) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this e-mail not found.';
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
        case 'A network error (such as timeout, interrupted connection, or unreachable host) has occurred.':
          return 'No internet connection.';
        case 'The email address is already in use by another account.':
          return 'Email address is already taken.';
        default:
          return 'Unknown error occurred.';
      }
    } else {
      return 'Unknown error occurred.';
    }
  }
}

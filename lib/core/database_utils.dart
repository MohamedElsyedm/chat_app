import 'package:chat_app/chat/data/model/message.dart';
import 'package:chat_app/rooms/data/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseUtils {
  static CollectionReference<UserModel> getUserCollection() => FirebaseFirestore
      .instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (docSnapshot, _) =>
            UserModel.fromJson(docSnapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  static CollectionReference<RoomModel> getRoomCollection() => FirebaseFirestore
      .instance
      .collection('rooms')
      .withConverter<RoomModel>(
        fromFirestore: (docSnapshot, _) =>
            RoomModel.fromJson(docSnapshot.data()!),
        toFirestore: (room, _) => room.toJson(),
      );

  //nested collection
  static CollectionReference<MessageModel> getMessageCollection(
    String roomId,
  ) => getRoomCollection()
      .doc(roomId)
      .collection('messages')
      .withConverter<MessageModel>(
        fromFirestore: (docSnapshot, _) =>
            MessageModel.fromJson(docSnapshot.data()!),
        toFirestore: (message, _) => message.toJson(),
      );

  //firebase auth

  // final _auth = FirebaseAuth.instance;
  /*
  final _googleSignIn = GoogleSignIn();

  Future<UserModel?> signInWithGoogleAccount() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      //signin with google auth tokens
      final cred = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      //signin with created google credential
      final userCred = await _auth.signInWithCredential(cred);

      UserModel userModel = UserModel.fromFirebaseUser(userCred.user);
      return userModel;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }*/

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    UserModel user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
    );

    CollectionReference<UserModel> userCollection = getUserCollection();
    userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    CollectionReference<UserModel> userCollection = getUserCollection();

    DocumentSnapshot<UserModel> docSnapshot = await userCollection
        .doc(credential.user!.uid)
        .get();
    return docSnapshot.data()!;
  }

  static Future<void> logout() {
    return FirebaseAuth.instance.signOut();
    // _googleSignIn.signOut();
  }

  //

  static Future<List<RoomModel>> getRoom() async {
    final roomsCollection = getRoomCollection();
    final querySnapshot = await roomsCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> createRoom(RoomModel room) async {
    final roomsCollection = getRoomCollection();
    final doc = roomsCollection.doc();
    room.id = doc.id;
    return doc.set(room);
  }

  static Future<void> deleteRoom(RoomModel room) async {
    final roomsCollection = getRoomCollection();
    final doc = roomsCollection.doc(room.id);
    return doc.delete();
  }

  //nested collection
  // messages
  static Future<void> insertMessageToRooms(MessageModel message) async {
    final messagesCollection = getMessageCollection(message.roomId);
    final doc = messagesCollection.doc();
    doc.set(message);
  }

  static Stream<List<MessageModel>> getRoomMessages(String roomId) {
    final messagesCollection = getMessageCollection(roomId);
    //return stream of data
    return messagesCollection
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map((docSnapshot) => docSnapshot.data())
              .toList(),
        );
  }
}

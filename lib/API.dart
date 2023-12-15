import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/image_picker.dart';
import 'package:myapp/signup.dart';
import 'chat_user.dart';
import 'message.dart';


class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<bool> userExists() async{
    return (await firestore.collection('users').doc(auth.currentUser!.uid).get()).exists;
  }

   Future<void> createUsers() async{
    final chatuser = ChatUser(
        name: nameController.text + ' ${surnameController.text}',
        about: 'Hello, I am using this app ',
        id: auth.currentUser!.uid,
        isOnline: false,
        image: imageURl ?? 'https://firebasestorage.googleapis.com/v0/b/myapp-b8edc.appspot.com/o/profilePic%2F2023-12-14%2014%3A02%3A58.717107?alt=media&token=62c14072-e016-41fd-8cbe-e76cbf559133',
        lastActive: DateTime.now().toString(),
        eMail: auth.currentUser!.email.toString(),
        pushToken: '');
        return await firestore.collection('users').doc(auth.currentUser!.uid).set(chatuser.toJson());
  }

  Future<void> createUser() async{
    final chatuser = ChatUser(name: auth.currentUser!.displayName.toString(),
        about: 'Hello, I am using this app ',
        id: auth.currentUser!.uid,
        image: auth.currentUser!.photoURL.toString(),
        isOnline: false,
        lastActive: DateTime.now().toString(),
        eMail: auth.currentUser!.email.toString(),
        pushToken: '');
    return await firestore.collection('users').doc(auth.currentUser!.uid).set(chatuser.toJson());
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> getMessage(ChatUser user){
    return firestore.collection('chats/${getId(user.id)}/messages/').snapshots();
  }

  static String getId(String id) => auth.currentUser!.uid.hashCode <= id.hashCode
      ? '${auth.currentUser!.uid}_$id'
      : '${id}_${auth.currentUser!.uid}';


  static Future<void> sendMessage(ChatUser chatUser,String msg) async{
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Message message = Message(Toid: chatUser.id, Fromid: auth.currentUser!.uid, msg: msg, read: '', type: '', sent: time);
    final ref = firestore.collection('chats/${getId(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  static Future<void> messageStatus(Message message) async{
    await firestore.collection('chats/${getId(message.Fromid)}/messages/').doc(message.sent).update({'read' :  DateTime.now().millisecondsSinceEpoch.toString()});
  }
}



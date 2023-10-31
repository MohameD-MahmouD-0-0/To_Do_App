import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled17/model/My_User.dart';
import 'package:untitled17/model/Taskes.dart';

class FirebaseUtils {
  static CollectionReference<Task>? getTaskCollection(String uid) {
    return getUserCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter<Task>(
        fromFirestore: ((snapshot, options) =>
            Task.fromFireStore(snapshot.data()!)),
        toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void>? addTaskToFireBase(Task task, String uid) {
    var taskCollection = getTaskCollection(uid);
    DocumentReference<Task>? docTaskRef = taskCollection?.doc();
    task.id = docTaskRef?.id;
    return docTaskRef?.set(task);
  }

  static Future<void>? deleteFromFireStore(Task task, String uid) {
    return getTaskCollection(uid)?.doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectiomnName)
        .withConverter<MyUser>(
        fromFirestore: (snapShot, options) =>
            MyUser.fromFireStore(snapShot.data()),
        toFirestore: (user, options) => user.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myuser) {
    return getUserCollection().doc(myuser.id).set(myuser);
  }

  static Future<MyUser?> readUser(String uid) async {
    var qureySnapShot = await getUserCollection().doc(uid).get();
    return qureySnapShot.data();
  }

  static Future<void>? EditIsDone(Task task, String uid) {
    return getTaskCollection(uid)?.doc(task.id).update({'isDone': task.isDone
    });
  }

  static Future<void>? EditIsTask(Task task, String uid) {
    return getTaskCollection(uid)?.doc(task.id).update(task.toFireStore());
  }
}

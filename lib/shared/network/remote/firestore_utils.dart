import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/todo_model.dart';

class FirestroeUtils {
  static CollectionReference<Todo> getTodosCollectionWithConvert() {
    return FirebaseFirestore.instance
        .collection(Todo.collectionName)
        .withConverter<Todo>(
          fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
          toFirestore: (item, _) => item.toJson(),
        );
  }

  static Future<void> addTodoToFirestore(
    String title,
    String description,
    String date,
    String time,
  ) {
    CollectionReference<Todo> collectionReference =
        getTodosCollectionWithConvert();
    DocumentReference<Todo> docRef = collectionReference.doc();

    Todo item = Todo(
      id: docRef.id,
      title: title,
      description: description,
      date: date,
      time: time,
    );

    return docRef.set(item);
  }

  static Future<void> deleteTask(Todo item) {
    DocumentReference<Todo> ref = getTodosCollectionWithConvert().doc(item.id);
    return ref.delete();
  }

  static Future<void> doneTask(Todo item) async {
    DocumentReference<Todo> ref = getTodosCollectionWithConvert().doc(item.id);
    ref.update({'isDone': item.isDone ? false : true});
  }

  static Future<void> updateTask({
    required Todo item,
    required String key,
    required dynamic value,
  }) async {
    DocumentReference<Todo> ref = getTodosCollectionWithConvert().doc(item.id);
    ref.update({key: value});
  }
}
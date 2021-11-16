import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/todo_model.dart';

class FirestroeUtils {
  static CollectionReference<Todo> getTodosCollection() {
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
    DateTime date,
    String time,
  ) {
    CollectionReference<Todo> collectionReference = getTodosCollection();
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
}

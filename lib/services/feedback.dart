import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

const feedbacksCollectionId = 'FEEDBACKS';
final _firestore = FirebaseFirestore.instance;
final _log = Logger();

final _feedbackCollection = _firestore.collection(feedbacksCollectionId);

Future<void> createFeedback(final String text) async {
  if (text.isEmpty) return;

  await _feedbackCollection.add({
    'text': text,
    'timestamp': FieldValue.serverTimestamp(),
  });
  _log.t("New feedback '$text' is successfully stored");
}

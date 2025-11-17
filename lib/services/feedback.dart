import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spacirtrasa/utils/utils.dart';

const feedbacksCollectionId = 'FEEDBACKS';
final _firestore = FirebaseFirestore.instance;
final _feedbackCollection = _firestore.collection(feedbacksCollectionId);

Future<void> createFeedback(String text) async {
  if (text.isEmpty) return;

  await _feedbackCollection.add({'text': text, 'timestamp': FieldValue.serverTimestamp()});
  logger.t("New feedback '$text' is successfully stored");
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimestampFormatter {
  String formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    final formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(date);
    return formattedDate;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Attendee {
  final String? id;
  final String name;
  final bool willYouCome;
  final String optional;
  final String blessing;
  final String? performance;
  final DateTime createdTime;
  Attendee({this.id, required this.name, required this.willYouCome, required this.optional, required this.blessing, this.performance, required this.createdTime});

  factory Attendee.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Attendee(
        id: documentId,
        name: data['name'] as String,
        willYouCome: data['willYouCome'] as bool,
        optional: data['optional'] as String,
        blessing: data['blessing'] as String,
        performance: data['performance'] as String,
        createdTime: (data['createdTime'] as Timestamp).toDate()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'willYouCome': willYouCome,
      'optional': optional,
      'blessing': blessing,
      'performance': performance,
      'createdTime': createdTime
    };
  }
}

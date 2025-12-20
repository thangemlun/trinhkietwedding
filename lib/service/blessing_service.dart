import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:wedding_landing_page/model/attendee.dart';
import 'package:wedding_landing_page/utils/toastification_util.dart';
class BlessingService {
  final _db = FirebaseFirestore.instance;
  bool isRunning = false;
  bool isPaused = false;

  final String attendeeCollections = "attendees";

  Future<List<Attendee>> getAttendees() async {
    final snapshot = await _db.collection(attendeeCollections)
    .orderBy("createdTime", descending: true).get();
    return snapshot.docs.map((doc) => Attendee.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  Future<void> submitAttendee(Attendee attendee) async{
    final doc = _db.collection(attendeeCollections).doc();
    await doc.set(attendee.toMap());
  }

  Future<void> startLoopBlessingFromAttendee(BuildContext context) async {
    int currentIndex = 0;
    isRunning = true;
    isPaused = false;
    final attendess = await this.getAttendees();
    print("start loop ${attendess.length} items running: ${isRunning} paused: ${isPaused}");
    while(isRunning) {
      if (isPaused) {
        await Future.delayed(Duration(milliseconds: 500));
        continue;
      }

      final current = attendess[currentIndex];
      await this._showToastAndWait(current, context);
      await Future.delayed(Duration(milliseconds: 3000));
      currentIndex = (currentIndex + 1) % attendess.length;
    }

  }

  void pause(){
    isPaused = true;
    isRunning = false;
  }
  void resume() {
    isPaused = false;
    isRunning = true;
  }
  void stop() {
    isRunning = false;
    isPaused = true;
    ToastificationUtil.dismissAll();
  }

  Future<void> _showToastAndWait(Attendee attendee, BuildContext context) async {
    final completer = Completer();

    ToastificationUtil.customToast(
      attendee.name,
      attendee.blessing,
      context,
      onPause: () => pause(),
      onResume: () => resume(),
      onClose: () => completer.complete(),
    );

    return completer.future;
  }

}
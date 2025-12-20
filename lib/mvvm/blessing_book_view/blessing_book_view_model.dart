import 'package:flutter/cupertino.dart';
import 'package:wedding_landing_page/service/blessing_service.dart';

import '../../model/attendee.dart';

class BlessingBookViewModel extends ChangeNotifier{
  final BlessingService _blessingService;

  BlessingBookViewModel(this._blessingService);

  List<Attendee> attendees = [];
  bool isLoading = false;

  Future<void> loadAttendees() async {
    isLoading = true;
    notifyListeners();
    attendees = await _blessingService.getAttendees();
    isLoading = false;
    notifyListeners();
  }
}
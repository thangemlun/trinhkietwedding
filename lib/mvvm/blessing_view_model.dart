import 'package:flutter/cupertino.dart';
import 'package:wedding_landing_page/model/attendee.dart';
import 'package:wedding_landing_page/service/blessing_service.dart';

class BlessingViewModel extends ChangeNotifier{
  final BlessingService blessingService;

  BlessingViewModel(this.blessingService);
  List<Attendee> attendees = [];
  bool isLoading = false;

  Future<void> loadAttendees() async {
    isLoading = true;
    notifyListeners();
    attendees = await blessingService.getAttendees();
    isLoading = false;
    notifyListeners();
  }
}
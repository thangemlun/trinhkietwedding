import 'package:flutter/material.dart';
import 'package:wedding_landing_page/model/attendee.dart';
import 'package:wedding_landing_page/mvvm/blessing_view_model.dart';
import 'package:provider/provider.dart';
import 'package:wedding_landing_page/service/blessing_service.dart';
import 'package:marquee/marquee.dart';
import 'package:wedding_landing_page/utils/text_style_util.dart';
class BlessingPopUpView extends StatelessWidget {
  final BlessingService blessingService = BlessingService();
  late BlessingViewModel blessingViewModel = BlessingViewModel(blessingService);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: blessingViewModel.loadAttendees(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(height: 0);
        }
        return ChangeNotifierProvider(
          create: (_) => blessingViewModel,
          child: Consumer<BlessingViewModel>(
            builder: (BuildContext context, BlessingViewModel value, Widget? child) {

              if (value.isLoading || value.attendees.isEmpty) {
                  return SizedBox(height: 0,);
                }else {
                  return blessingMarquee(blessingViewModel.attendees);
                }
              },
          ),
        );
      }
    );
  }

  Widget blessingMarquee(List<Attendee> attendees) {
    String text = "";
    for (Attendee attendee in attendees) {
      text += "${attendee.name}: ${attendee.blessing}\t 💕 \t";
    }
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 400,
        height: 50,
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: BoxBorder.all(
            color: Color(0xFFe6e4dd),
            width: 5.0, style: BorderStyle.solid
          ),
          shape: BoxShape.rectangle,
        ),
        child: Marquee(
          textDirection: TextDirection.ltr,
          text: text,
          crossAxisAlignment: CrossAxisAlignment.start,
          style: TextStyleUtil.marqueeTextStyle(),
          scrollAxis: Axis.horizontal,
          blankSpace: 20.0,
          velocity: 50.0,
          pauseAfterRound: const Duration(seconds: 1),
          startPadding: 10.0,
        ),
      ),
    );
  }
}

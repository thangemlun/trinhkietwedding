import 'package:flutter/cupertino.dart';
import 'package:wedding_landing_page/model/attendee.dart';
import 'package:wedding_landing_page/mvvm/blessing_book_view/blessing_book_view_model.dart';
import 'package:provider/provider.dart';
import 'package:wedding_landing_page/utils/text_style_util.dart';
import '../../service/blessing_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BlessingBookView extends StatelessWidget{
  final BlessingService blessingService = BlessingService();
  Size screenSize;
  bool? isMobile;
  BlessingBookView(this.screenSize, {this.isMobile});
  @override
  Widget build(BuildContext context) {
    BlessingBookViewModel blessingViewModel = BlessingBookViewModel(blessingService);
    return FutureBuilder(
        future: blessingViewModel.loadAttendees(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(height: 0);
          }
          return ChangeNotifierProvider(
            create: (_) => blessingViewModel,
            child: Consumer<BlessingBookViewModel>(
              builder: (BuildContext context, BlessingBookViewModel value, Widget? child) {

                if (value.isLoading || value.attendees.isEmpty) {
                  return SizedBox(height: 0,);
                }else {
                  return isMobile != null && isMobile!
                      ? buildBlessingBookMobile(blessingViewModel.attendees)
                      : buildBlessingBook(blessingViewModel.attendees);
                }
              },
            ),
          );
        }
    );
  }

  Widget buildBlessingBook(List<Attendee> attendees) {
    return SizedBox(
        height: screenSize.height * 0.8,
        child: Padding(
          padding: EdgeInsets.only(left: screenSize.width * 0.05,
              top: screenSize.height * 0.03),
          child: AlignedGridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              itemCount: attendees.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(attendees[index].name,
                      style: TextStyleUtil.luxuriousTextStyle(screenSize.width * 0.032),
                    ),
                    Text(attendees[index].blessing,
                      style: TextStyleUtil.commonTextStyle(screenSize.width * 0.01),
                    ),
                  ],
                );
              }),
        )
      );
  }

  Widget buildBlessingBookMobile(List<Attendee> attendees) {
    return SizedBox(
        height: screenSize.height * 0.2,
        child: Padding(
          padding: EdgeInsets.only(
              left: screenSize.width * 0.05,
              top: screenSize.height * 0.05),
          child: ListView.builder(
              itemCount: attendees.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(attendees[index].name,
                      style: TextStyleUtil.luxuriousTextStyle(screenSize.width * 0.08),
                    ),
                    Text(attendees[index].blessing,
                      style: TextStyleUtil.commonTextStyle(screenSize.width * 0.02),
                    ),
                  ],
                );
              }),
        )
    );
  }

}
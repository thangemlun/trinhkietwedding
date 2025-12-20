import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wedding_landing_page/mvvm/blessing_book_view/blessing_book_view.dart';
class MemoryBookPage extends StatefulWidget{

  MemoryBookPage({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => MemoryPageState();
}

class MemoryPageState extends State<MemoryBookPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color(0xFFeae5db),
      ),
      child: ResponsiveBuilder(builder: (context, constraint) {
        return constraint.isDesktop
            ? desktopScreen(constraint)
            : mobileScreen(constraint);
      }),
    );
  }

  Widget desktopScreen(SizingInformation constraint) {
    Size screenSize = constraint.screenSize;
    double aspectBookRatio = 2880/1620;
    double bookWidth = screenSize.width/ 1.5;
    double bookHeight = bookWidth/aspectBookRatio;
    return SingleChildScrollView(
      child: SizedBox(
        width: screenSize.width,
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(screenSize.width/2.5, screenSize.height * 0.01),
              child: Image.asset("assets/images/so_luu_but.png",
                  width: screenSize.width/3.2),
            ),
            Transform.translate(
              offset: Offset(screenSize.width/5, screenSize.height * 0.21),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  width: bookWidth,
                  height: bookHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/book.png"),
                    fit: BoxFit.cover),
                  ),
                  child: BlessingBookView(screenSize),
                ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mobileScreen(SizingInformation constraint) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/so_luu_but.png",
              width: constraint.screenSize.width/2),
          Container(
            width: constraint.screenSize.width,
            height: constraint.screenSize.height/2,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/half_book.png"))
            ),
            child:  BlessingBookView(constraint.screenSize, isMobile: true,),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
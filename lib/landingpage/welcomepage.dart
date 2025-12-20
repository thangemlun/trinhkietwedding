import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_animate/flutter_animate.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}):super(key: key);
  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  late AnimationController welComeTextController;
  late AnimationController placeTextController;
  late AnimationController placeTextMobileController;
  String welcomeTextStr = "Trinh & Kiệt cưới rồi nè";
  String weddingDateStr = "20  &  22.03.2026";
  String weddingPlaceStr = "HỒ CHÍ MINH & AN GIANG";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    welComeTextController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    placeTextMobileController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    placeTextController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    welComeTextController.forward();
    placeTextController.forward();
    placeTextMobileController.forward();
  }

  void reload() {
    setState(() {
      reAnimate();
    });
  }

  void reAnimate() {
    welComeTextController.reset();
    placeTextController.reset();
    placeTextMobileController.reset();
    welComeTextController.forward();
    placeTextController.forward();
    placeTextMobileController.forward();
  }


  @override
  void dispose() {
    welComeTextController.dispose();
    placeTextController.dispose();
    placeTextMobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, constraint) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/trinhkiet1.jpg"),
              fit: BoxFit.cover,
              opacity: 0.5
            ),
          ),
          child: ResponsiveBuilder(
            builder: (context, constraint) {
              double width = constraint.screenSize.width;
              return !constraint.isDesktop ? buildMobileLayout() :
              Stack(
                children: [
                  Positioned(
                    left: 350,
                    top: 350,
                    child: Container(
                      width: width/3,
                          child: Image.asset("assets/images/1.4.png"),
                    ).animate(
                      controller: welComeTextController
                    ).fadeIn(duration: 1.seconds),
                  ),

                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontFamily: "WelcomePlace",
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      child: Text (weddingDateStr,
                        style: welcomePlaceTextStyle(),),
                    ).animate(
                        controller: placeTextController
                    ).fadeIn(duration: 1.seconds),
                  ),

                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontFamily: "WelcomePlace",
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      child: Text (weddingPlaceStr,
                        style: welcomePlaceTextStyle(),),
                    ).animate(
                      controller: placeTextController
                    ).fadeIn(duration: 1.seconds),
                  ),
                ],
              );
            }
          ),
        );
      }
    );
  }

  Widget buildMobileLayout() {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(8),
          child: AspectRatio(
            aspectRatio: 16/10,
            child: Container(
              child: Image.asset("assets/images/1.4.png"),
            ).animate(
              controller: welComeTextController
            ).fadeIn(duration: 1.seconds),
          ),),
          DefaultTextStyle(
            style: TextStyle(
              fontFamily: "WelcomePlace",
              fontSize: 24,
              color: Colors.white,),
            child: Text(weddingDateStr),
          ).animate(
            controller: placeTextMobileController
          ).fadeIn(
            duration: 1.seconds
          ),
          DefaultTextStyle(
            style: TextStyle(
              fontFamily: "WelcomePlace",
              fontSize: 24,
              color: Colors.white,),
            child: Text(weddingPlaceStr),
          ).animate(
              controller: placeTextMobileController
          ).fadeIn(
              duration: 1.seconds
          )
        ],
      ),
    );
  }
  
  TextStyle welcomeTextStyle() {
    return GoogleFonts.luxuriousScript(
      fontSize: 220,
      color: Colors.white,
    );
  }

  TextStyle welcomePlaceTextStyle() {
    return TextStyle(
      fontFamily: "WelcomePlace",
      fontSize: 24,
      color: Colors.white,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

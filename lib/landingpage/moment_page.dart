import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
class MomentPage extends StatefulWidget{

  MomentPage({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => MomentPageState();

}

class MomentPageState extends State<MomentPage>
    with TickerProviderStateMixin{

  late final AnimationController momentScript1Controller;
  late final AnimationController coupleHeadLineController;

  @override
  void initState() {
    // TODO: implement initState
    momentScript1Controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    coupleHeadLineController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    momentScript1Controller.forward();
    coupleHeadLineController.forward();
  }

  void reload() {
    print("reload");
    setState(() {
      reAnimate();
    });
  }

  void reAnimate() {
    momentScript1Controller.reset();
    momentScript1Controller.forward();
    coupleHeadLineController.reset();
    coupleHeadLineController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    momentScript1Controller.dispose();
    coupleHeadLineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsiveBuilder(
      builder: (context, constraint) {
        return Container(
          width: double.infinity,
          height: constraint.screenSize.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/moment1_background.png"),
                fit: BoxFit.cover
            )
          ),
          child: constraint.isDesktop
              ? buildDesktopView(constraint)
              : buildMobileView(constraint),
        );
      },
    );
  }

  Widget buildDesktopView(SizingInformation constraint) {
    return SingleChildScrollView(
      child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Transform.translate(
              offset: Offset(constraint.screenSize.width/ 10, constraint.screenSize.height * 0.1,),
              child: Container(
                width: constraint.screenSize.width/3,
                child: Image.asset("assets/images/moment1.png"),
              ).animate(
                  controller: momentScript1Controller
              ).fadeIn(duration: 1.seconds),
            ),
            Transform.translate(
                offset: Offset(-constraint.screenSize.width*0.1,
                    constraint.screenSize.height*0.4),
                child: Container(
              width: constraint.screenSize.width/4,
              child: Image.asset("assets/images/tutrinh_tuankiet.png"),
            )).animate(
              controller: coupleHeadLineController
            ).fadeIn(duration: 1.seconds)
          ],
        ),
    );
  }

  Widget buildMobileView(SizingInformation constraint) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Container(
            width: constraint.isMobile ? constraint.screenSize.width :
            constraint.screenSize.width/2,
            child: Image.asset("assets/images/moment1.png"),
          ).animate(
              controller: momentScript1Controller
          ).fadeIn(duration: 1.seconds),

          Container(
            width: constraint.isMobile ? constraint.screenSize.width/1.2 :
            constraint.screenSize.width/2,
            child: Image.asset("assets/images/tutrinh_tuankiet.png"),
          ).animate(
              controller: momentScript1Controller
          ).fadeIn(duration: 1.seconds),
        ],
      ),
    );
  }
}
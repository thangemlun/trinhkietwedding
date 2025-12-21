import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/typer_animation.dart';
class ThirdMomentPage extends StatefulWidget{

  ThirdMomentPage({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => ThirdMomentPageState();

}

class ThirdMomentPageState extends State<ThirdMomentPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  bool _cached = false;
  static const String backgroundAssetPath = "assets/images/moment3_background.png";
  static const String trinhKietAssetPath = "assets/images/tutrinh_tuankiet.png";

  final Image trinhKietImg = Image.asset(trinhKietAssetPath);

  final AssetImage backgroundImg = AssetImage(backgroundAssetPath);

  late final momentScript1Controller;
  final GlobalKey<TypingTextAnimState> typingTextState = GlobalKey<TypingTextAnimState>();
  late final coupleHeadLineController;

  @override
  void initState() {
    // TODO: implement initState
    momentScript1Controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    coupleHeadLineController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    momentScript1Controller.forward();
    coupleHeadLineController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_cached) {
      return;
    } else {
      _cached = true;
      precacheImage(
        const AssetImage(trinhKietAssetPath),
        context,
      );
      precacheImage(
        const AssetImage(backgroundAssetPath),
        context,
      );
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose moment 3");
    momentScript1Controller.dispose();
    coupleHeadLineController.dispose();
    super.dispose();
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
    typingTextState.currentState?.reload();
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
                image: AssetImage(backgroundAssetPath),
                fit: BoxFit.cover
            )
          ),
          child: constraint.isDesktop ? buildDesktopView(constraint)
              : buildMobileView(constraint),
        );
      },
    );
  }

  Widget buildDesktopView(SizingInformation constraint) {
    return SingleChildScrollView(
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Transform.translate(
                offset: Offset(constraint.screenSize.width/20,
                    constraint.screenSize.height* 0.3),
                child: Container(
                  width: constraint.screenSize.width/4,
                  height: constraint.screenSize.height,
                  child: trinhKietImg,
                )).animate(
                controller: coupleHeadLineController
            ).fadeIn(duration: 1.seconds),
            Transform.translate(
              offset: Offset(constraint.screenSize.width*0.01,
                  -constraint.screenSize.height * 0.2),
              child: Container(
                width: constraint.screenSize.width/2.5,
                child:
                buildMomentScript(fontSize: constraint.screenSize.width* 0.01),
              ).animate(
                  controller: momentScript1Controller
              ).fadeIn(duration: 1.seconds),
            ),
          ],
        ),
    );
  }

  Widget buildMobileView(SizingInformation constraint) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: constraint.isMobile ? constraint.screenSize.width:
            constraint.screenSize.width,
            child: buildMomentScript(),
          ).animate(
              controller: momentScript1Controller
          ).fadeIn(duration: 1.seconds),

          Container(
            width: constraint.isMobile ? constraint.screenSize.width/1.2 :
            constraint.screenSize.width/2,
            child: Image.asset(trinhKietAssetPath),
          ).animate(
              controller: momentScript1Controller
          ).fadeIn(duration: 1.seconds),
        ],
      ),
    );
  }

  Widget buildMomentScript({double? fontSize}) {
    return TypingTextAnim(
      key: typingTextState,
      duration: Duration(milliseconds: 800),
      textSpan: TextSpan(
        style: TextStyle(
          fontFamily: "WelcomePlace",
          fontSize: fontSize ?? 18,
          fontWeight: FontWeight.w200,
          color: Colors.white,
        ),
        children: [
          const TextSpan(text: "Hôm nay, vòng quay định mệnh ấy đã một lần nữa xoay tròn mở ra một\nvòng tròn mới:\n\n"),
          const TextSpan(text: "Vòng tròn của Tình yêu – của “hai” trở thành “một”\n"),
          const TextSpan(text: "Một vòng tròn hoàn hảo, không điểm đầu – cũng chẳng có điểm kết thúc. \n"),
          const TextSpan(text: "Một vòng tròn mà mỗi khoảnh khắc sau này sẽ tiếp tục được viết bằng\n"),
          const TextSpan(text: "sự đồng hành, sẻ chia và bình yên bên nhau.\n\n\n"),
          const TextSpan(text: "Khoảnh khắc gặp nhau là duyên.\n"),
          const TextSpan(text: "Khoảnh khắc gắn bó là phận. \n"),
          const TextSpan(text: "Khoảnh khắc nắm tay bước vào hôn lễ hôm nay – đó là định mệnh.\n\n"),
          const TextSpan(text: "KHOẢNH KHẮC – THE MOMENT\n"),
          const TextSpan(text: "Chỉ cần đúng người, đúng lúc… là mãi mãi. \n"),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
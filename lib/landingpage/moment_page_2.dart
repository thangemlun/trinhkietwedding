import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/typer_animation.dart';
class SecondMomentPage extends StatefulWidget{

  SecondMomentPage({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => SecondMomentPageState();

}

class SecondMomentPageState extends State<SecondMomentPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

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
  void dispose() {
    momentScript1Controller.dispose();
    coupleHeadLineController.dispose();
    typingTextState.currentState?.dispose();
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
                image: AssetImage("assets/images/moment2_background.png"),
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
    return ListView(
          children: [
            Transform.translate(
              offset: Offset(constraint.screenSize.width/2,
                  constraint.screenSize.height * 0.1),
              child: SizedBox(
                width: constraint.screenSize.width/4,
                height: constraint.screenSize.height/2,
                child: buildMomentScript(constraint.screenSize.width* 0.008),
              ).animate(
                  controller: momentScript1Controller
              ).fadeIn(duration: 1.seconds),
            ),
            Transform.translate(
                offset: Offset(constraint.screenSize.width/4,
                    constraint.screenSize.height * 0.2),
                child: SizedBox(
                  width: constraint.screenSize.width/100,
                  height: constraint.screenSize.height/4,
                  child: Image.asset("assets/images/tutrinh_tuankiet.png"),
            )).animate(
              controller: coupleHeadLineController
            ).fadeIn(duration: 1.seconds)
          ],
    );
  }

  Widget buildMobileView(SizingInformation constraint) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: constraint.isMobile ? constraint.screenSize.width:
            constraint.screenSize.width,
            child: buildMomentScript(18),
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

  Widget buildMomentScript(double fontSize) {
    return TypingTextAnim(
      key: typingTextState,
      duration: Duration(milliseconds: 800),
      textSpan: TextSpan(
        style: TextStyle(
          fontFamily: "WelcomePlace",
          fontSize: fontSize,
          fontWeight: FontWeight.w200,
          color: Colors.white,
        ),
        children: [
          const TextSpan(text: "Từ khoảnh khắc tình cờ ấy, mỗi giây phút đi cùng nhau đều là một phép màu:\n\n"),
          const TextSpan(text: "Khoảnh khắc lần đầu hẹn hò, thành phố bỗng như dịu dàng hơn.\n"),
          const TextSpan(text: "Khoảnh khắc chạm tay, bỗng thấy cả thế giới gói gọn trong lòng bàn tay. \n"),
          const TextSpan(text: "Khoảnh khắc cùng vượt qua thử thách, yêu thương càng thêm bền chắc.\n"),
          const TextSpan(text: "Khoảnh khắc nói ra hai chữ “chúng ta”, định mệnh thêm một lần được khắc sâu.\n\n"),
          const TextSpan(text: "Mọi hành trình của Trinh và Kiệt là chuỗi khoảnh khắc kỳ diệu nối tiếp nhau –\n"),
          const TextSpan(text: "ngẫu nhiên nhưng lại chính xác đến lạ kỳ. Như thể vũ trụ đã viết sẵn cho họ một\n"),
          const TextSpan(text: "vòng quay yêu thương mà chỉ cần đúng lúc, đúng nơi… họ sẽ tìm được nhau. \n"),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
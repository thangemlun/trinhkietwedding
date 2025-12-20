import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/typer_animation.dart';
class FinalPage extends StatefulWidget{

  FinalPage({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => FinalPageState();

}

class FinalPageState extends State<FinalPage> with TickerProviderStateMixin {

  late final momentScript1Controller;
  final GlobalKey<TypingTextAnimState> typingTextState = GlobalKey<TypingTextAnimState>();
  late final coupleHeadLineController;

  @override
  void initState() {
    // TODO: implement initState
    momentScript1Controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    coupleHeadLineController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    reAnimate();
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
                  image: AssetImage("assets/images/final_page_background.png"),
                  fit: BoxFit.cover
              )
          ),
          child: constraint.isDesktop ? buildDesktopView(constraint.screenSize.width)
              : buildMobileView(constraint),
        );
      },
    );
  }

  Widget buildDesktopView(double width) {
    return Stack(
      children: [
        Positioned(
          left: width/8,
          top: 250,
          child: Transform.rotate(
            angle: -0.08,
            child: Container(
              width: width/4,
              child: Image.asset("assets/images/final_page1.png"),
            ).animate(
                controller: momentScript1Controller
            ).fadeIn(duration: 1.seconds),
          ),
        ),
        Positioned(
          right: width/8,
          top: 50,
          child: Transform.rotate(
            angle: 0.05,
            child: Container(
              width: width/4,
              child: Image.asset("assets/images/final_page2.png"),
            ).animate(
                controller: momentScript1Controller
            ).fadeIn(duration: 1.seconds),
          ),
        ),
        Positioned(
          right: width/20,
          bottom: 100,
          child: Container(
            width: width/2.5,
            child: Image.asset("assets/images/final_page3.png"),
          ).animate(
              controller: momentScript1Controller
          ).fadeIn(duration: 1.seconds),
        ),
      ],
    );
  }

  Widget buildMobileView(SizingInformation constraint) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: -0.08,
            child: Container(
              padding: EdgeInsets.all(16),
              width: constraint.isMobile ? constraint.screenSize.width:
              constraint.screenSize.width,
              child: Image.asset("assets/images/final_page2.png"),
            ).animate(
                controller: momentScript1Controller
            ).fadeIn(duration: 1.seconds),
          ),
          Transform.rotate(
            angle: 0.05,
            child: Container(
              padding: EdgeInsets.all(16),
              width: constraint.isMobile ? constraint.screenSize.width:
              constraint.screenSize.width,
              child: Image.asset("assets/images/final_page1.png"),
            ).animate(
                controller: momentScript1Controller
            ).fadeIn(duration: 1.seconds),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.all(16),
            width: constraint.isMobile ? constraint.screenSize.width:
            constraint.screenSize.width,
            child: Image.asset("assets/images/final_page3.png"),
          ).animate(
              controller: momentScript1Controller
          ).fadeIn(duration: 1.seconds),
        ],
      ),
    );
  }

  Widget buildMomentScript() {
    return TypingTextAnim(
      key: typingTextState,
      duration: Duration(milliseconds: 800),
      textSpan: TextSpan(
        style: TextStyle(
          fontFamily: "WelcomePlace",
          fontSize: 18,
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

}
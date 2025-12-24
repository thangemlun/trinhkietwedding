import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/typer_animation.dart';
class DonatePage extends StatefulWidget{

  DonatePage({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => DonatePageState();

}

class DonatePageState extends State<DonatePage> with TickerProviderStateMixin {

  late final momentScript1Controller;
  final GlobalKey<TypingTextAnimState> typingTextState = GlobalKey<TypingTextAnimState>();
  late final coupleHeadLineController;
  bool _cached = false;
  static const String donateQRpath = "assets/images/donate_page_background.png";
  double aspectRatio = 16/9;
  @override
  void initState() {
    // TODO: implement initState
    momentScript1Controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    coupleHeadLineController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    reAnimate();
  }

  @override
  void didChangeDependencies() {
    if (_cached) {
      return;
    } else {
      _cached = true;
      precacheImage(AssetImage(donateQRpath),
          context);
    }
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
          width: constraint.screenSize.width,
          height: constraint.screenSize.width / aspectRatio,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(donateQRpath),
                fit: BoxFit.cover
            )
          ),
          child: constraint.isDesktop
              ? buildDesktopView(constraint.screenSize)
              : buildMobileView(constraint),
        );
      },
    );
  }

  Widget buildDesktopView(Size size) {
    double height = size.width / aspectRatio;
    print("mmt3:w-${size.width} & h-${height}");
    return Stack(
      children: [
        Positioned(
          left: size.width * 0.2,
          bottom: height * 0.2,
          child: Container(
            width: size.width/4,
            child: Image.asset("assets/images/donate_QR.png"),
          ).animate(
              controller: momentScript1Controller
          ).fadeIn(duration: 1.seconds),
        ),
        Positioned(
          right: size.width * 0.2,
          bottom: height * 0.12,
          child: Container(
            width: size.width/4,
            height: size.height* 0.4,
            child: SvgPicture.asset("assets/images/26.svg"),
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
          Container(
            width: constraint.screenSize.width,
            child: Image.asset("assets/images/donate_QR.png"),
          ).animate(
              controller: momentScript1Controller
          ).fadeIn(duration: 1.seconds),
          Container(
            width: constraint.screenSize.width,
            height: constraint.screenSize.height * 0.2,
            child: SvgPicture.asset("assets/images/26.svg"),
          ).animate(
              controller: momentScript1Controller
          ).fadeIn(duration: 1.seconds)
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
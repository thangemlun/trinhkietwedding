import 'package:flutter/material.dart';
import 'package:wedding_landing_page/utils/typer_animation.dart';
import 'package:responsive_builder/responsive_builder.dart';
class StoryPage extends StatefulWidget{
  const StoryPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => StoryPageState();
}

class StoryPageState extends State<StoryPage>
    with TickerProviderStateMixin {

  static const double adjust1200FontSize = 20;
  static const double adjustless1200FontSize = 12;
  //rgb(230, 228, 221)
  late AnimationController _controller;
  late Animation<double> _animation;

  late AnimationController _photoCardController;
  late Animation<double> _photoCardAnimation;

  final GlobalKey<TypingTextAnimState> typingTextState = GlobalKey();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(begin: 0.5, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _photoCardController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _photoCardAnimation = Tween<double>(begin: 0.5, end: 1.0)
        .animate(CurvedAnimation(parent: _photoCardController, curve: Curves.easeIn));

    // chạy tất cả animation ngay khi khởi tạo
    _controller.forward();
    _photoCardController.forward();
  }

  void reload() {
    print("reload");
    setState(() {
      reAnimate();
    });
  }

  void reAnimate() {
    _controller.reset();
    _controller.forward();
    _photoCardController.reset();
    _photoCardController.forward();
    typingTextState.currentState?.reload();
  }

  @override
  void dispose() {
    _controller.dispose();
    _photoCardController.dispose();
    typingTextState.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color.fromRGBO(230, 228, 221, 1)
        ),
        child: ResponsiveBuilder(
              builder: (context, constraint) {
                if (constraint.isDesktop) {
                  return buildDesktopScreen(constraint);
                }
                return buildMobileScreen(constraint);
              }
            ),
      );
  }

  Widget buildDesktopScreen(SizingInformation constraint) {
    double layoutHeight = constraint.screenSize.width/2.2;
    return Container(
      height: layoutHeight,
      child: SingleChildScrollView(
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: constraint.screenSize.width*0.1,
                top: layoutHeight * 0.01,
              ),
              child: buildStoryPhoto(constraint.screenSize),
            ),
            Expanded(
              child: Container(
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.translate(
                        offset: Offset(-constraint.screenSize.width*0.03, layoutHeight * 0.12),
                        child: buildStoryHeadline(constraint.screenSize)),
                    Transform.translate(
                      offset: Offset(-constraint.screenSize.width*0.005, layoutHeight * 0.12),
                      child: buildStoryScript(22, constraint)
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMobileScreen(SizingInformation constraint){
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                Container(
                    width: constraint.screenSize.width /1.5,
                    child: Image.asset("assets/images/story_photo.png"),
                ),
                Container(
                  width: constraint.screenSize.width /1.5,
                  child: Image.asset("assets/images/4.1.png",),
                ),
                buildMobileScript(constraint),
              ],
            ),
    );
  }

  Widget buildStoryPhoto(Size screenSize) {
    double expectedWidth = screenSize.width/2;
    double aspectRatio = 4730/3375;
    return FadeTransition(
      opacity: _animation,
      child: Container(
                width: expectedWidth,
                height: expectedWidth/aspectRatio,
                child: Image.asset("assets/images/story_photo.png"),
              ),
    );
  }

  Widget buildStoryScript(double fontSize, SizingInformation constraint) {
    double width = !constraint.isDesktop
        ? constraint.screenSize.width/0.5
        : constraint.screenSize.width/3.5;
    double height = width/(16/10);
    return Container(
        width: width,
        height: height,
        child: TypingTextAnim(
            key: typingTextState,
            duration: Duration(milliseconds: 800),
            textSpan: TextSpan(
              style: TextStyle(
                fontFamily: "WelcomePlace",
                fontSize: width*0.04,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              ),
              children: [
                const TextSpan(text: "Có những câu chuyện tình yêu bắt đầu bằng lời hẹn ước…\n\n"),
                const TextSpan(text: "Nhưng với Trinh và Kiệt, tất cả khởi đầu từ một "),
                TextSpan(
                  text: "khoảnh khắc ",
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const TextSpan(text: " – duy nhất và bất ngờ.\n\n"),
                const TextSpan(text: "Đêm Countdown rực rỡ giữa phố đi bộ.\n"),
                const TextSpan(text: "Âm nhạc vang lên, ánh đèn bừng sáng, hàng\n"),
                const TextSpan(text: "chục nghìn người cùng đếm ngược thời khắc\n"),
                const TextSpan(text: "chuyển giao năm mới."),
              ],
            ),
          )
      );
  }

  Widget buildStoryHeadline(Size screenSize) {
    double width = screenSize.width/4;
    double aspectRatio = 3840/2160;
    double height = width/aspectRatio;
    return FadeTransition(opacity: _photoCardAnimation,
      child: Container(
      width: width,
      height: height,
      child: Image.asset("assets/images/4.1.png"),
    ),
  );
  }

  double getExpectedWidth(BuildContext context) {
    double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
      return deviceWidth * 0.5;
  }

  Widget buildMobileScript(SizingInformation constraint) {
    return Container(
      width: constraint.isTablet
          ? constraint.screenSize.width/2
          : constraint.screenSize.width/1.5,
      child: TypingTextAnim(
          key: typingTextState,
          duration: Duration(milliseconds: 800),
          textSpan: TextSpan(
            style: TextStyle(
              fontFamily: "WelcomePlace",
              fontSize: 16,
              fontWeight: FontWeight.w200,
              color: Colors.black,
            ),
            children: [
              const TextSpan(text: "Có những câu chuyện tình yêu bắt đầu bằng lời hẹn ước…\n\n"),
              const TextSpan(text: "Nhưng với Trinh và Kiệt, tất cả khởi đầu từ một "),
              TextSpan(
                text: "khoảnh khắc ",
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold
                ),
              ),
              const TextSpan(text: " – duy nhất và bất ngờ.\n\n"),
              const TextSpan(text: "Đêm Countdown rực rỡ giữa phố đi bộ.\n"),
              const TextSpan(text: "Âm nhạc vang lên, ánh đèn bừng sáng, hàng\n"),
              const TextSpan(text: "chục nghìn người cùng đếm ngược thời khắc\n"),
              const TextSpan(text: "chuyển giao năm mới."),
            ],
          ),
        ),
    );
  }
}
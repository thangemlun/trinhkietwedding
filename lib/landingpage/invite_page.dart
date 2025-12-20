import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class InvitePage extends StatefulWidget{
  const InvitePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => InvitePageState();
}

class InvitePageState extends State<InvitePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  late AnimationController _photoCardController;
  late Animation<Offset> _photoCardAnimation;

  late AnimationController _inviteCardController;
  late Animation<Offset> _inviteCardAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(-0.1, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _photoCardController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _photoCardAnimation = Tween<Offset>(begin: Offset(0, -2), end: Offset(-0.15, 0))
        .animate(CurvedAnimation(parent: _photoCardController, curve: Curves.easeOut));

    _inviteCardController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _inviteCardAnimation = Tween<Offset>(begin: Offset(1, 0), end: Offset(0.7, 0.05))
        .animate(CurvedAnimation(parent: _inviteCardController, curve: Curves.easeOut));

    // chạy tất cả animation ngay khi khởi tạo
    reAnimate();
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
    _inviteCardController.reset();
    _inviteCardController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _photoCardController.dispose();
    _inviteCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/trinhkiet1.jpg"),
          fit: BoxFit.cover)
        ),
        child: Center(
          child: Stack(
            children: [
              buildEnvelop(),
              buildPhotoCard(),
              buildInviteCard()
            ],
          ),
        ),
      );
  }

  Widget buildEnvelop() {
    double aspectRatio = 636/800;
    return LayoutBuilder(
      builder: (context, constraint) {
        double width = getExpectedWidth(context)/1.5;
        double height = width/aspectRatio;
        return SlideTransition(
          position: _animation,
          child: Image.asset(
            'assets/images/envelope.png',
            width: width,
            height: height,
          ),
        );
      }
    );
  }

  Widget buildPhotoCard() {
    double aspectRatio = 4554/3375;
    return LayoutBuilder(
      builder: (context, constraint) {
        double width = getExpectedWidth(context)/1.2;
        double height = width/aspectRatio;
        return SlideTransition(
          position: _photoCardAnimation,
          child: Image.asset(
            'assets/images/photoCard.png',
            width: width,
            height: height,
          ),
        );
      }
    );
  }

  Widget buildInviteCard() {
    double aspectRatio = 1101/1620;
    return LayoutBuilder(
      builder: (context, constraint) {
        double width = getExpectedWidth(context)/1.8;
        double height = width/aspectRatio;
        return SlideTransition(
          position: _inviteCardAnimation,
          child: Image.asset(
            'assets/images/invite_card.png',
            width: width,
            height: height,
          ),
        );
      }
    );
  }

  double getExpectedWidth(BuildContext context) {
    double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;

    if (deviceWidth >= 1024) {
      // Desktop / iPad
      return deviceWidth * 0.5;
    } else if (deviceWidth >= 600) {
      // Tablet / mobile lớn
      return deviceWidth * 0.8;
    } else {
      // Mobile nhỏ
      return deviceWidth * 1;
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
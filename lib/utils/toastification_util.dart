import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:google_fonts/google_fonts.dart';
class ToastificationUtil {
  static void toast(String message, String description, {Alignment alignment = Alignment.topRight}) {
    toastification.show(// optional if you use ToastificationWrapper
      style: ToastificationStyle.flat,

      autoCloseDuration: const Duration(milliseconds: 5000),
      title: Text("$message",
        style: commonTextStyle(),),
      description: Text("$description",
        style: commonTextStyle(),),
      // you can also use RichText widget for title and description parameters
      alignment: alignment,
      direction: TextDirection.ltr,
      animationDuration: Duration(milliseconds: 1000),
      showIcon: true, // show or hide the icon
      primaryColor: getToastColor(),
      backgroundColor: Color(0xFFd9d1c3).withOpacity(0.2),
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,

    );
  }

  static void customToast(String name, String blessing, BuildContext context,
  {required VoidCallback onPause,
    required VoidCallback onResume,
    required VoidCallback onClose,}) {
    final item = toastification.showCustom(
      context: context,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: Duration(seconds: 2),
      animationDuration: Duration(milliseconds: 500),
        builder: (context, holder) {
        return GestureDetector(
          onLongPressStart:(_) {
            holder.pause();
            onPause();
          } ,
        onLongPressEnd: (_) {
          onResume();
          holder.start();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: getToastColor().withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                )
              ],
            ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Transform.translate(offset: Offset(0, -10),
                  child: Text(
                    name,
                    style: nameToastTextStyle(),
                  ),
                ),
                Transform.translate(offset: Offset(0, -20),
                  child: Text(
                    blessing,
                    style: commonTextStyle(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      animationBuilder: (context, animation, alignment, child) {
        final offset = Tween<Offset> (
          begin: Offset(0, -0.2),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(position: offset,
          child: child,
        );
      }
    );
    item.addListenerOnTimeStatus(() {
      if(!item.isRunning) {
        onClose();
      }
    });
  }


  static Color getToastColor() {
    return const Color(0xffd9d1c3);
  }

  static TextStyle commonTextStyle() {
    return TextStyle(
      fontSize: 16,
      fontFamily: "WelcomePlace",
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
  }

  static TextStyle nameToastTextStyle() {
    return GoogleFonts.luxuriousScript(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
  }

  static void dismissAll() {
    toastification.dismissAll();
  }
}
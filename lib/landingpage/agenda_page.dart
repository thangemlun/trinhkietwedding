import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:wedding_landing_page/model/attendee.dart';
import 'package:wedding_landing_page/service/blessing_service.dart';
import 'package:wedding_landing_page/utils/attendance_selector.dart';
import '../utils/typer_animation.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
class AgendaPage extends StatefulWidget{
  AgendaPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => AgendaPageState();
}

class AgendaPageState extends State<AgendaPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderFieldState> _nameKey = GlobalKey<FormBuilderFieldState>();
  final GlobalKey<FormBuilderFieldState> _optionalKey = GlobalKey<FormBuilderFieldState>();
  final GlobalKey<FormBuilderFieldState> _performanceKey = GlobalKey<FormBuilderFieldState>();
  final GlobalKey<FormBuilderFieldState> _blessingKey = GlobalKey<FormBuilderFieldState>();
  final BlessingService blessingService = BlessingService();
  final GlobalKey<TypingTextAnimState> typingTextState = GlobalKey<TypingTextAnimState>();
  bool _isFormValid = false;
  bool isAttending = true;
  bool _cached = false;
  static const String giaTienPath = "assets/images/gia_tien.png";
  static const String tiecCuoiPath = "assets/images/tiec_cuoi.png";
  static const String vuQuyPath = "assets/images/vu_quy.png";
  static const String thanhHonPath = "assets/images/thanh_hon.png";

  final Image giaTienImg = Image.asset(giaTienPath);
  final Image tiecCuoiImg = Image.asset(tiecCuoiPath);
  final Image vuQuyImg = Image.asset(vuQuyPath);
  final Image thanhHonImg = Image.asset(thanhHonPath);

  late AnimationController tagLineControl;
  late AnimationController weddingStepControl;
  late AnimationController formAnimControl;
  late Animation<double> fadeTagLineAnimation;
  late Animation<double> fadeWeddingStepAnimation;
  late Animation<double> fadeFormAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_cached) {
      return;
    } else {
      _cached = true;
      precacheImage(const AssetImage(giaTienPath), context);
      precacheImage(const AssetImage(tiecCuoiPath), context);
      precacheImage(const AssetImage(vuQuyPath), context);
      precacheImage(const AssetImage(thanhHonPath), context);
    }
  }

  @override
  void initState() {
    tagLineControl = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2)
    );
    weddingStepControl = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2)
    );
    formAnimControl = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2)
    );

    fadeWeddingStepAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: weddingStepControl, curve: Curves.easeOut)
    );

    fadeFormAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: formAnimControl, curve: Curves.easeOut)
    );

    fadeTagLineAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: tagLineControl, curve: Curves.easeOut)
    );

    tagLineControl.forward();
    weddingStepControl.forward();
    formAnimControl.forward();
  }

  void reload() {
    print("reload");
    setState(() {
      reAnimate();
    });
  }

  void reAnimate() {
    tagLineControl.reset();
    tagLineControl.forward();
    weddingStepControl.reset();
    weddingStepControl.forward();
    formAnimControl.reset();
    formAnimControl.forward();
    typingTextState.currentState?.reload();
  }


  @override
  void dispose() {
    tagLineControl.dispose();
    weddingStepControl.dispose();
    formAnimControl.dispose();
    typingTextState.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, constraint) {
        return Container(
          child: constraint.isDesktop ? wideScreen(constraint) : mobileScreen(),
        );
      }
    );
  }

  Widget wideScreen(SizingInformation constraint) {
    double width = constraint.screenSize.width/0.5;
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFeae5db),
      ),
      width: double.infinity,
      height: constraint.screenSize.height,
      child: Center(
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTagLine(width)
                  .animate(controller: tagLineControl)
                  .fadeIn(duration: 1.seconds)
                      .scale(),
                  buildAgendaStep(width),
                  SizedBox(height: 100,),
                  buildChungVuiAndForm(width)
                ],
              ),
          ),
        ),
    );
  }

  Widget mobileScreen() {
    double width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
          color: Color(0xFFeae5db),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(8.0),
              child: buildTagLine(width * 4),
            ),

            Padding(padding: EdgeInsets.all(8.0),
              child: buildGiaTienStep(width/1.4),
            ),
            Padding(padding: EdgeInsets.all(8.0),
              child: buildTiecCuoiStep(width/1.4),
            ),
            Padding(padding: EdgeInsets.all(8.0),
              child: buildVuQuyStep(width/1.4),
            ),
            Padding(padding: EdgeInsets.all(8.0),
              child: buildThanhHonStep(width/1.4),
            ),
            buildChungVui(width*6),
            attendeeForm(),
          ],
        ),
      );
  }

  Widget attendeeForm() {
    return FormBuilder(
      key: _formKey,
      onChanged: () {
        setState(() {
          _isFormValid = _formKey.currentState?.isValid ?? false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        decoration: BoxDecoration(
          color: Color(0xFFe6e4dd),
          borderRadius: BorderRadius.circular(8),
          border: BoxBorder.all(
            style: BorderStyle.solid,
            width: 5.0,
            color: Colors.white
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12,),
            Text("Tên của bạn*",
              style: commonTextStyle(),
            ),
            SizedBox(height: 12,),
            FormBuilderTextField(
                key: _nameKey,
                name: 'name',
                style: commonTextStyle(),
                decoration: inputDecoration(""),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required()
                ]),
            ),
            SizedBox(height: 16,),

            AttendanceSelector(
                initialValue: isAttending,
                onChanged: (value) {
              print("selected: $value");
            }),
            SizedBox(height: 16,),

            Text("Bạn đến cùng người thương chứ?\n"
                "Nhờ bạn ghi số lượng người tham dự giúp vợ chồng mình nha*",
              style: commonTextStyle(),),
            SizedBox(height: 12,),
            FormBuilderTextField(
              key: _optionalKey,
              name: 'optional',
              style: commonTextStyle(),
              keyboardType: TextInputType.number,
              decoration: inputDecoration(""),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Vui lòng nhập số lượng'),
              ]),
            ),
            SizedBox(height: 16,),
            Text("Lời chúc của bạn*",
              style: commonTextStyle(),
            ),
            SizedBox(height: 12,),
            FormBuilderTextField(
              key: _blessingKey,
              name: 'blessing',
              style: commonTextStyle(),
              decoration: inputDecoration(""),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required()
              ]),
            ),
            SizedBox(height: 16,),
            Text("Bạn tặng tụi mình 1 tiết mục nha! \nĐăng ký bài bên dưới đây nè",
              style: commonTextStyle(),),
            SizedBox(height: 12,),
            FormBuilderTextField(
              key: _performanceKey,
              name: 'performance',
              style: commonTextStyle(),
              decoration: inputDecoration(''),
            ),
            SizedBox(height: 24),

            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12)
              ),
              padding: EdgeInsets.all(16),
              color: Color(0xFF717171),
              disabledColor: Color(0xFFf0f1f5),
              onPressed: _isFormValid ? () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  final data = _formKey.currentState!.value;
                  print('Dữ liệu gửi: $data');
                  Attendee attendee = Attendee(name: data['name'],
                      willYouCome: isAttending,
                      optional: data['optional'],
                      blessing: data['blessing'],
                      performance: data['performance'],
                      createdTime: DateTime.now());
                  print(attendee.toMap());
                  blessingService.submitAttendee(attendee).whenComplete(() {
                    print("Save attendee successful");
                    _formKey.currentState?.reset();
                  });
                }
              } : null,
              child: Center(
                  child: Text('BẤM VÀO ĐÂY ĐỂ GỬI NÈ \n'
                          'TỤI MÌNH RẤT MONG ĐỢI ĐƯỢC GẶP BẠN!',
                    style: commonTextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    ),
                ),
              ),
          ],
        ),
      ).animate(
        controller: formAnimControl
      ).fadeIn(duration: 1.seconds),
    );
  }

  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      labelStyle: textStyle(),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
    );
  }

  TextStyle textStyle() {
    return TextStyle(
      fontSize: 16,
      fontFamily: "WelcomePlace",
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
  }
  TextStyle commonTextStyle({Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontFamily: "WelcomePlace",
      fontWeight: FontWeight.w500,
      color: color ?? Colors.black,
    );
  }

  Widget buildTagLine(double boxWidth) {
    double width = boxWidth/5;
    double aspectRatio = 6000/1005;
    double height = width/aspectRatio;
    return Align(
      alignment: Alignment(-0.5,0),
      child: Container(
        width: width,
        height: height,
        child: Image.asset("assets/images/agenda_tag_line.png"),
      ),
    );
  }

  Widget buildAgendaStep(double boxWidth) {
    print("wtf : $boxWidth");
    double minimizeW = boxWidth/12;
    return FadeTransition(
      opacity: fadeWeddingStepAnimation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildGiaTienStep(minimizeW),
          buildTiecCuoiStep(minimizeW),
          buildVuQuyStep(minimizeW),
          buildThanhHonStep(minimizeW),
        ],
      ),
    );
  }

  Widget buildGiaTienStep(double boxWidth) {
    double width = boxWidth;
    double aspectRatio = 1466/ 2160;
    double height = width/aspectRatio;
    return Container(
      width: width,
      height: height,
      child: giaTienImg,
    );
  }

  Widget buildTiecCuoiStep(double boxWidth) {
    double width = boxWidth;
    double aspectRatio = 1466/ 2160;
    double height = width/aspectRatio;
    return Container(
      width: width,
      height: height,
      child: tiecCuoiImg,
    );
  }

  Widget buildVuQuyStep(double boxWidth) {
    double width = boxWidth;
    double aspectRatio = 1466/ 2160;
    double height = width/aspectRatio;
    return Container(
      width: width,
      height: height,
      child: vuQuyImg,
    );
  }


  Widget buildThanhHonStep(double boxWidth) {
    double width = boxWidth;
    double aspectRatio = 1466/ 2160;
    double height = width/aspectRatio;
    return Container(
      width: width,
      height: height,
      child: thanhHonImg,
    );
  }

  Widget buildChungVuiAndForm(double boxWidth) {
    return Center(
      child: Container(
        width: boxWidth/3,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: buildChungVui(boxWidth)),
              Expanded(
                  child: attendeeForm()),
            ],
          ),
      ),
    );
  }

  Widget buildChungVui(double boxWith) {
    double width = boxWith/6;
    double aspectRatio = 3808/3375;
    double height = width/aspectRatio;
    String firstLine = "Sự hiện diện của bạn là niềm vinh hạnh của vợ chồng mình.";
    String secondLine = "Nhớ xác nhận lịch trước 28.02.2026 nha!";

    print("chungVui with ${width}");
    return FadeTransition(
      opacity: fadeWeddingStepAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: height,
            child: Image.asset("assets/images/chung_vui.png"),
          ),
          LayoutBuilder(
            builder: (context, constraint) {
              double maxWidth = constraint.maxWidth;
              return Container(
                      margin: maxWidth < 600
                          ? EdgeInsets.only(left: 25, bottom: 24)
                          : EdgeInsets.only(left: 36, bottom: 24),
                      child: TypingTextAnim(
                        textStyle: commonTextStyle(),
                        key: typingTextState,
                          textSpan: TextSpan(
                              style: TextStyle(
                                fontFamily: "WelcomePlace",
                                fontSize: boxWith*0.004,
                                fontWeight: FontWeight.w200,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(text: "${firstLine}\n"),
                                TextSpan(
                                  text: indentString(content: "${secondLine}",
                                  indentSize: firstLine.length - secondLine.length,
                                ))
                            ]
                      )),
                    );
            }
          )
        ],
      ),
    );
  }

  String indentString({int? indentSize, required String content}) {
    if (indentSize != null) {
      String indentStr = "";
      for (int i = 0; i < indentSize; i++) {
        indentStr = indentStr += '\t';
      }
      return indentStr+content;
    }
    return content;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
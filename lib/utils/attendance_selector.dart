import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AttendanceSelector extends StatefulWidget{
  final Function(bool value) onChanged;
  final bool? initialValue;

  const AttendanceSelector({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<StatefulWidget> createState() => AttendanceSelectorState();
}

class AttendanceSelectorState extends State<AttendanceSelector> {
  bool? selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = widget.initialValue;
  }

  Widget _buildOption({required String label, required bool value}){
    final isSelected = selected == value;
    final selectedColor = Color(0xFF717171);
    final unselectedColor = Color(0xFFf0f1f5);
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = value;
        });
        widget.onChanged(value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16,
          vertical: 14,),
        width: double.infinity,
        decoration: BoxDecoration(
            color: isSelected ? selectedColor : unselectedColor,
            borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label, style: textStyle(isSelected),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bạn sẽ đến chứ*',
        style: commonTextStyle(),),
        SizedBox(height: 12,),
        _buildOption(label: 'Chắc chắn rồi, sao mà bỏ qua được',
            value: true),
        SizedBox(height: 12),
        _buildOption(
          label: 'Huhu tiếc quá',
          value: false,
        ),
      ],
    );
  }

  TextStyle textStyle(bool isSelected) {
    return TextStyle(
      fontSize: 16,
      fontFamily: "WelcomePlace",
      fontWeight: FontWeight.w500,
      color: isSelected ? Colors.white : Colors.black,
    );
  }

  TextStyle commonTextStyle() {
    return TextStyle(
      fontSize: 16,
      fontFamily: "WelcomePlace",
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
  }
}
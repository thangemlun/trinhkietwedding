import 'package:flutter/material.dart';

class TypingTextAnim extends StatefulWidget {
  final TextSpan textSpan;
  final Duration duration;
  final TextStyle? textStyle;

  const TypingTextAnim({
    super.key,
    required this.textSpan,
    this.duration = const Duration(seconds: 5),
    this.textStyle
  });

  @override
  TypingTextAnimState createState() => TypingTextAnimState();
}

class TypingTextAnimState extends State<TypingTextAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _charCount;
  late String _plainText;

  @override
  void initState() {
    super.initState();
    // Lấy toàn bộ text từ TextSpan (chỉ phần text, không style)
    _plainText = widget.textSpan.toPlainText();

    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..forward();

    _charCount =
        StepTween(begin: 0, end: _plainText.length).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _charCount,
      builder: (context, child) {
        // Cắt text theo số ký tự hiện tại
        final visibleText = _plainText.substring(0, _charCount.value);

        return RichText(
          text: TextSpan(
            style: widget.textSpan.style,
            children: _buildSpans(visibleText),
          ),
        );
      },
    );
  }

  List<TextSpan> _buildSpans(String visibleText) {
    final spans = <TextSpan>[];
    final parts = visibleText.split("khoảnh khắc");

    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i]));
      if (i < parts.length - 1) {
        spans.add(const TextSpan(
          text: "khoảnh khắc",
          style: TextStyle(decoration: TextDecoration.underline, decorationThickness: 4.0),
        ));
      }
    }
    return spans;
  }

  void reload() {
    setState(() {
      _controller.reset();
      _controller.forward();
    });
  }
}

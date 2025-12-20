import 'package:flutter/cupertino.dart';

class MusicViewModel extends ChangeNotifier{
  final isPlaying = ValueNotifier<bool>(false);

  void toggle() {
    isPlaying.value = !isPlaying.value;
  }
}
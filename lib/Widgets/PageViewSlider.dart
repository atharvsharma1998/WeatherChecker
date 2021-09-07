import 'package:flutter/material.dart';

class PageViewSlider extends StatelessWidget {
  //const PageViewSlider({Key? key}) : super(key: key);
  bool isActive;
  PageViewSlider(this.isActive);

  @override
  Widget build(BuildContext context) {
    return
      AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: 2),
        width: isActive ? 12 : 5,
        height: 5,
        decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white54,
            borderRadius: BorderRadius.circular(3)
        ), duration: Duration(milliseconds: 200),
    );
  }
}

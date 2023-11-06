import 'package:flutter/material.dart';

import '../../data/common/common.dart';

class ImageButton extends StatefulWidget {

   ImageButton( {super
       .key,
     required this.imagePath, this.click, this.width, this.height,});

  String imagePath;
  Function? click;
  double? width;
  double? height;
  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(widget.click ==null) return;
        widget.click!.call();
      },
      child: Container(
        color: Colors.transparent,
        width: widget.width,
        height: widget.height,
        child: Image.asset(Common.imagePath + widget.imagePath),
      ),
    );
  }
}

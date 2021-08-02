import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:ksegment_view/segment/commons.dart';
import 'package:ksegment_view/segment/segment_pos.dart';

class SegmentFlipCard extends StatelessWidget {
  final SegmentPos pos;
  final String title;
  final double angle;
  final Color cardBgColor;
  final TextStyle titleStyle;
  final double borderRadius;

  const SegmentFlipCard(
    this.title, {
    Key? key,
    this.pos = SegmentPos.left,
    this.angle = 0,
    this.cardBgColor = Colors.white,
    this.titleStyle = const TextStyle(color: Colors.black87, fontSize: 15),
    this.borderRadius = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      /// chỗ này cũng khó hiểu nốt =)))
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateY(toRadian(degree: angle)),

      alignment: Alignment.centerLeft,

      /// child
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(borderRadius),
          ),
        ),
        child: Transform(
          transform: pos == SegmentPos.left
              ? (Matrix4.identity()..rotateY(pi))
              : (Matrix4.identity()..rotateY(0)),
          alignment: Alignment.center,
          child: Text(title, style: titleStyle),
        ),
      ),
    );
  }
}

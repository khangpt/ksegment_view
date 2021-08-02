import 'package:flutter/material.dart';
import 'package:ksegment_view/segment/segment_pos.dart';

class SingleSegment extends StatelessWidget {
  final String title;
  final SegmentPos pos;
  final VoidCallback? onTap;
  final TextStyle titleStyle;
  final double? borderRadius;

  const SingleSegment(
    this.title, {
    Key? key,
    this.titleStyle = const TextStyle(fontSize: 15, color: Colors.white),
    this.pos = SegmentPos.left,
    this.onTap,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius:
            borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
        child: Container(
          alignment: Alignment.center,
          child: Text(title, style: titleStyle),
        ),
      ),
    );
  }
}

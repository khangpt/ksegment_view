import 'package:flutter/material.dart';
import 'package:ksegment_view/segment/commons.dart';
import 'package:ksegment_view/segment/segment_pos.dart';
import 'package:ksegment_view/segment/single_segment.dart';

class KSegmentView extends StatefulWidget {
  final Size boundary;
  final Color backgroundColor;
  final Color borderColor;
  final double borderThick;
  final double borderRadius;
  final TextStyle titleStyle;

  /// only allow maximum 2 segments
  final List<String> segments;
  final CardBuilder flipBuilder;

  /// current segment selected
  final SegmentPos initialSelected;

  /// called after change segment
  final ValueChanged<SegmentPos>? onChanged;

  const KSegmentView(
    this.segments,
    this.flipBuilder, {
    Key? key,
    this.initialSelected = SegmentPos.left,
    this.boundary = Size.zero,
    this.backgroundColor = Colors.black87,
    this.borderColor = Colors.white,
    this.titleStyle = const TextStyle(fontSize: 15, color: Colors.white),
    this.borderRadius = 25,
    this.borderThick = 2,
    this.onChanged,
  })  : assert(segments.length >= 2),
        super(key: key);

  @override
  _KSegmentViewState createState() => _KSegmentViewState();
}

class _KSegmentViewState extends State<KSegmentView>
    with SingleTickerProviderStateMixin {
  /// animation controller
  late final AnimationController _controller;
  late final Animation<double> _animation;

  /// current selected
  late bool isLeft;

  @override
  void initState() {
    super.initState();

    isLeft = widget.initialSelected == SegmentPos.left;

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700))
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.completed:
          case AnimationStatus.dismissed:
            widget.onChanged?.call(isLeft ? SegmentPos.left : SegmentPos.right);
            break;
          default:
        }
      });

    _animation = Tween<double>(begin: isLeft ? 180 : 0, end: isLeft ? 0 : 180)
        .animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.bounceOut,
            reverseCurve: Curves.bounceIn));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _flip() {
    if (_controller.isCompleted)
      _controller.reverse();
    else
      _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: widget.boundary.width,
            height: widget.boundary.height,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: widget.borderColor,
                width: widget.borderThick,
              ),
            ),
            child: Row(children: [
              SingleSegment(
                widget.segments.first,
                pos: SegmentPos.left,
                borderRadius: widget.borderRadius,
                titleStyle: widget.titleStyle,
                onTap: _flip,
              ),
              SingleSegment(
                widget.segments.last,
                pos: SegmentPos.right,
                borderRadius: widget.borderRadius,
                titleStyle: widget.titleStyle,
                onTap: _flip,
              ),
            ]),
          ),

          /// flip card
          AnimatedBuilder(
            animation: _animation,
            builder: (_, child) {
              isLeft = _animation.value >= 90;

              return Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  width: widget.boundary.width / 2,
                  child: widget.flipBuilder(context, isLeft, _animation.value));
            },
          ),
        ],
      ),
    );
  }
}

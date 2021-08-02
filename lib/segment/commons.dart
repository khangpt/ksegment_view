import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:ksegment_view/segment/segment_flip_card.dart';

/// convert from degree to radian angle value
double toRadian({double degree = 0}) => degree * pi / 180;

/// build an segment card
/// * [leftCard]: this is left or right card when flipping
/// * [angle]: the angle (in degree) of card when flipping
typedef CardBuilder = SegmentFlipCard Function(
    BuildContext context, bool leftCard, double angle);

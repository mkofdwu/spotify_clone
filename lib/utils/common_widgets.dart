import 'package:flutter/material.dart';

Text styledText(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? letterSpacing,
  bool oneLineEllipsis = false,
}) =>
    Text(
      text,
      maxLines: oneLineEllipsis ? 1 : null,
      overflow: oneLineEllipsis ? TextOverflow.ellipsis : null,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
      ),
    );

Widget expandedColumnStart(List<Widget> children) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );

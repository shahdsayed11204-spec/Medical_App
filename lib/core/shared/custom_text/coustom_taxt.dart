
import 'package:flutter/material.dart';

Widget CustomText({
  required String text,
  Color? color,
  FontWeight? font,
  double? size,
  int? maxLines,
  TextAlign? textAlign,
}) => Text(
  text,
  maxLines: maxLines,
  overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
  textAlign: textAlign ?? TextAlign.center,
  textScaler: const TextScaler.linear(1.0),

  style: TextStyle(
    fontWeight: font,
    fontSize: size,
    color: color,
  ),
);
import 'package:flutter/material.dart';

getBoxDecoration(
    {Color? color, double? radius, Border? border, Gradient? gradient}) {
  return BoxDecoration(
      color:Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5))
      ],
      border:
      border ?? Border.all(color: Colors.white.withOpacity(0.05)),
      gradient: gradient);
}
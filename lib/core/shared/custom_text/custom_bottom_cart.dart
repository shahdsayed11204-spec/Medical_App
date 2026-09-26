import 'package:flutter/material.dart';

import '../../constant/app_colors.dart';
import 'coustom_taxt.dart';


class CustomBottomCart extends StatelessWidget {
  const CustomBottomCart({super.key, required this.text, this.onTap, this.width, this.height, this.redius, this.colortext, this.colorbottom, this.size,});

  final String text;
  final Function()? onTap;
  final double ? width;
  final double ? height;
  final double ? size;
  final double ? redius;
  final Color ? colortext;
  final Color ? colorbottom;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
          height: height,
          padding: EdgeInsetsGeometry.symmetric(horizontal:15.0,vertical: 7),
          decoration: BoxDecoration(
            color: colorbottom??AppColors.secondaryColor,
            borderRadius: BorderRadiusGeometry.circular(redius ?? 15),
          ),
          child: Center(child: CustomText(text: text,size: size??16,font: FontWeight.bold,color: colortext??Colors.white))
      ),
    );
  }
}

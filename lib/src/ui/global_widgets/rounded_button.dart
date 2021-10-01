import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? fontSize;
  final Color textColor, backgroundColor, borderColor;
  final double? heigth;
  final bool fullWidth;
  final EdgeInsets padding;
  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.textColor = Colors.white,
    this.backgroundColor = primaryColor,
    this.borderColor = primaryColor,
    this.fullWidth = true,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    this.fontSize,
    this.heigth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Container(
        height: this.heigth,
        width: fullWidth ? double.maxFinite : null,
        padding: this.padding,
        decoration: BoxDecoration(
          color: this.backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1.4, color: this.borderColor),
        ),
        child: Text(
          this.label,
          textAlign: TextAlign.center,
          style: FontStyles.normal.copyWith(
            fontWeight: FontWeight.w600,
            color: this.textColor,
            fontSize: this.fontSize,
          ),
        ),
      ),
      minSize: 30,
      onPressed: this.onPressed,
      color: Colors.transparent,
      padding: EdgeInsets.zero,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weather_app/view/constants/color.dart';
import 'package:weather_app/view/container/widget/ui_text.dart';

class UIButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final String title;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final bool loading;
  final bool enabled;

  const UIButtonWidget(
      {Key? key,
      this.onPressed,
      required this.padding,
      required this.title,
      this.titleStyle,
      this.backgroundColor,
      required this.loading,
      required this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextButton(
        onPressed: (enabled == true) ? onPressed : null,
        style: TextButton.styleFrom(
            backgroundColor: onPressed != null
                ? (backgroundColor ?? UIColors.primary)
                    .withOpacity((enabled == true) ? 1.0 : 0.25)
                : UIColors.description),
        child: Align(
          alignment: Alignment.center,
          child: FittedBox(
            child: UIText(
              text: title,
              style:  TextStyle(
                fontSize: 17,
                color: (onPressed != null) ? UIColors.white : UIColors.black
              ).merge(titleStyle),
            ),
          ),
        ),
      ),
    );
  }
}

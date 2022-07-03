import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/view/constants/color.dart';

typedef OnChanged = Function(String);
typedef OnSubmit = Function(String);

class UnderLineInput extends StatelessWidget {
  final String? hint;
  final bool isRequired;
  final bool enabled;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final VoidCallback? onRightIconPressed;
  final VoidCallback? onPressedDetail;
  final VoidCallback? onFocus;
  final OnChanged? onChanged;
  final OnSubmit? onSubmitted;
  final Widget? iconRight;
  final String? unit;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const UnderLineInput(
      {Key? key,
      this.hint,
      this.isRequired = true,
      this.enabled = true,
      this.obscureText = false,
      this.errorMessage,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.onRightIconPressed,
      this.onPressedDetail,
      this.onFocus,
      this.onChanged,
      this.onSubmitted,
      this.iconRight,
      this.unit,
      this.textInputAction,
      this.maxLines,
      this.inputFormatters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: UIColors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: TextField(
                      maxLines: maxLines,
                      onTap: onFocus,
                      controller: controller,
                      inputFormatters: inputFormatters,
                      onChanged: onChanged,
                      onSubmitted: onSubmitted,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.25,
                      ),
                      obscureText: obscureText,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        enabled: enabled,
                        hintStyle: TextStyle(
                            fontSize: 14,
                            height: 1.25,
                            color: UIColors.black.withOpacity(0.6)),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        isCollapsed: true,
                      ),
                      keyboardType: keyboardType,
                      textInputAction: textInputAction,
                    ),
                  ),
                ),
              ),
              if (iconRight != null)
                Material(
                  color: UIColors.white,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: onRightIconPressed,
                      child: iconRight),
                ),
            ],
          ),
          Divider(
            height: 1,
            color: UIColors.description,
          ),
        ],
      ),
    );
  }
}

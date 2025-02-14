import 'package:employee_app/core/constant/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonTextfield extends StatelessWidget {
  const CommonTextfield(
      {super.key,
      this.placeholder,
      this.prefixIcon,
      this.sufixIcon,
      this.readOnly = false,
      this.onTap,
      this.onChanged,
      this.initialValue,
      this.controller,
      this.style});
  final TextEditingController? controller;
  final String? placeholder;
  final String? prefixIcon;
  final String? sufixIcon;
  final String? initialValue;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextStyle? style;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        onChanged: onChanged,
        readOnly: readOnly,
        onTap: onTap,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        style: style,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          hintText: placeholder,
          hintStyle: TextStyle(color: ThemeColor.placeholder, fontSize: 16),
          prefixIconConstraints: BoxConstraints.tight(Size.fromWidth(40)),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(prefixIcon ?? ""),
                )
              : null,
          suffixIconConstraints: BoxConstraints.tight(Size.fromWidth(40)),
          suffixIcon: sufixIcon != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  child: SvgPicture.asset(sufixIcon ?? ""),
                )
              : null,
          border: border,
          focusedBorder: border,
          disabledBorder: border,
          errorBorder: border,
          enabledBorder: border,
        ),
      ),
    );
  }

  OutlineInputBorder get border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: ThemeColor.border),
      );
}

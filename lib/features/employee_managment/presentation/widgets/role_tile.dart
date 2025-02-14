import 'package:employee_app/core/constant/theme_color.dart';
import 'package:flutter/material.dart';

class RoleTile extends StatelessWidget {
  const RoleTile({super.key, required this.title, required this.onTap});

  final String title;
  final void Function(String title)? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: ThemeColor.divider,
        ))),
        child: InkWell(
          onTap: () => onTap?.call(title),
          child: Center(
            child: Text(title),
          ),
        ),
      ),
    );
  }
}

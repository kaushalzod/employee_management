import 'package:employee_app/core/constant/theme_color.dart';
import 'package:employee_app/features/employee_managment/presentation/widgets/role_tile.dart';
import 'package:flutter/material.dart';

class RoleBottomsheet {
  static const List _roles = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner"
  ];

  static void open(BuildContext context, {void Function(String title)? onTap}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black38,
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(color: ThemeColor.divider),
            height: 211 + MediaQuery.viewPaddingOf(context).bottom,
            child: Material(
              child: Column(
                children: [
                  for (String role in _roles)
                    RoleTile(title: role, onTap: onTap),
                  SizedBox(
                    height: MediaQuery.viewPaddingOf(context).bottom,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

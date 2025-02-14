import 'package:employee_app/core/utils/extensions.dart';
import 'package:employee_app/features/employee_managment/presentation/widgets/action_button.dart';
import 'package:flutter/material.dart';

class BackCancelButton extends StatelessWidget {
  const BackCancelButton({super.key});
  @override
  Widget build(BuildContext context) {
    return ActionButton(
      title: "Cancel",
      primary: false,
      onTap: () {
        context.pop();
      },
    );
  }
}

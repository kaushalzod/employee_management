import 'package:employee_app/core/constant/image_path.dart';
import 'package:employee_app/features/employee_managment/presentation/utils/employee_str_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoRecordFound extends StatelessWidget {
  const NoRecordFound({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(ImagePath.noEmployee),
            Text(
              EmpStrConst.noEmployee,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}

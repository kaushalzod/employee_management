import 'package:employee_app/core/constant/image_path.dart';
import 'package:employee_app/core/utils/extensions.dart';
import 'package:employee_app/core/widgets/common_textfield.dart';
import 'package:employee_app/core/widgets/date_picker.dart';
import 'package:employee_app/features/employee_managment/presentation/cubit/employee_cubit.dart';
import 'package:employee_app/features/employee_managment/presentation/utils/employee_str_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditStartdateTextfield extends StatelessWidget {
  const EditStartdateTextfield({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocSelector<EmployeeCubit, EmployeeCubitState, String?>(
        selector: (state) => state.startDate,
        builder: (context, startDate) {
          final date = startDate != null && startDate != EmpStrConst.noDate
              ? startDate.dateFormat
              : "";
          return CommonTextfield(
            controller: TextEditingController(text: date),
            readOnly: true,
            style: TextStyle(fontSize: 14),
            prefixIcon: ImagePath.event,
            placeholder: "No date",
            onTap: () async {
              final String? date = await datePickerDialog(context,
                  selectedDate: DateTime.tryParse(startDate ?? ""));
              if (date != null &&
                  date != EmpStrConst.noDate &&
                  context.mounted) {
                context.read<EmployeeCubit>().updateStartDate(date);
              }
            },
          );
        },
      ),
    );
  }
}

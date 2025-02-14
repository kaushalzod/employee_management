import 'package:employee_app/core/constant/image_path.dart';
import 'package:employee_app/core/utils/extensions.dart';
import 'package:employee_app/core/widgets/common_textfield.dart';
import 'package:employee_app/core/widgets/date_picker.dart';
import 'package:employee_app/features/employee_managment/presentation/cubit/employee_cubit.dart';
import 'package:employee_app/features/employee_managment/presentation/utils/employee_str_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditEnddateTextfield extends StatelessWidget {
  const EditEnddateTextfield({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          BlocSelector<EmployeeCubit, EmployeeCubitState, (String?, String?)>(
        selector: (state) => (state.startDate, state.endDate),
        builder: (context, dates) {
          final date = dates.$2 != null && dates.$2 != EmpStrConst.noDate
              ? dates.$2!.dateFormat
              : "";
          return CommonTextfield(
            controller: TextEditingController(text: date),
            readOnly: true,
            style: TextStyle(fontSize: 14),
            prefixIcon: ImagePath.event,
            placeholder: "No date",
            onTap: () async {
              final String? date = await datePickerDialog(
                context,
                showNextMonday: false,
                showNextTuesday: false,
                showNextWeek: false,
                showNoDate: true,
                selectedDate: DateTime.tryParse(dates.$2 ?? ""),
                startDate: DateTime.tryParse(dates.$1 ?? ""),
              );
              if (date != null &&
                  date != EmpStrConst.noDate &&
                  context.mounted) {
                context.read<EmployeeCubit>().updateEndDate(date);
              }
            },
          );
        },
      ),
    );
  }
}

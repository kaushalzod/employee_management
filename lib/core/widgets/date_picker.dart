import 'package:employee_app/core/constant/image_path.dart';
import 'package:employee_app/core/constant/theme_color.dart';
import 'package:employee_app/core/utils/extensions.dart';
import 'package:employee_app/features/employee_managment/presentation/utils/employee_str_constant.dart';
import 'package:employee_app/features/employee_managment/presentation/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Future<String?> datePickerDialog(
  BuildContext context, {
  DateTime? selectedDate,
  DateTime? startDate,
  DateTime? endDate,
  bool showNoDate = false,
  bool showNextMonday = true,
  bool showNextTuesday = true,
  bool showNextWeek = true,
}) async {
  String? dateString;
  await showDialog<Widget>(
    context: context,
    builder: (BuildContext context) {
      return DatePicker(
        selectedDate: selectedDate,
        startDate: startDate,
        showNoDate: showNoDate,
        showNextMonday: showNextMonday,
        showNextTuesday: showNextTuesday,
        showNextWeek: showNextWeek,
        onSelect: (val) {
          print(val);
          dateString = val;
        },
      );
    },
  );
  return dateString;
}

class DatePicker extends StatefulWidget {
  const DatePicker(
      {super.key,
      this.startDate,
      this.endDate,
      this.selectedDate,
      this.showNoDate = false,
      this.showNextMonday = true,
      this.showNextTuesday = true,
      this.showNextWeek = true,
      this.onSelect});
  final DateTime? selectedDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool showNoDate;
  final bool showNextMonday;
  final bool showNextTuesday;
  final bool showNextWeek;
  final ValueChanged<String?>? onSelect;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime? selectedDate = widget.selectedDate;
  late DateRangePickerController _controller;
  String headerString = '';
  late DateTime currentDate;
  int selected = -1;
  String? currentSelectionStatus;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    _controller = DateRangePickerController();
    _controller.selectedDate = widget.selectedDate;
    if (_controller.selectedDate != null &&
        isSameDay(_controller.selectedDate!, currentDate)) {
      selected = 1;
    }
  }

  _selectDate({String? date}) {
    currentSelectionStatus = date;
    if (date == EmpStrConst.noDate) {
      _controller.selectedDate = null;
    } else if (date != null && date.isNotEmpty) {
      _controller.selectedDate = DateTime.tryParse(date);
      _controller.displayDate = DateTime.tryParse(date);
    }
  }

  bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  String _getNextWeekday(DateTime fromDate, int targetWeekday) {
    int difference = targetWeekday - fromDate.weekday;
    if (difference <= 0) {
      difference += 7;
    }
    return fromDate.add(Duration(days: difference)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AlertDialog(
        actionsAlignment: MainAxisAlignment.start,
        actions: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: ThemeColor.divider))),
            child: Row(
              spacing: 16,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    SvgPicture.asset(ImagePath.event),
                    Text(
                      selectedDate != null
                          ? selectedDate!.toString().dateFormat
                          : "No Date",
                    ),
                  ],
                ),
                Spacer(),
                ActionButton(
                  title: "Cancel",
                  primary: false,
                  onTap: () => Navigator.pop(context),
                ),
                ActionButton(
                  onTap: () {
                    widget.onSelect?.call(currentSelectionStatus);
                    Navigator.pop(context);
                  },
                  title: "Save",
                ),
              ],
            ),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 24),
        insetPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        content: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  if (widget.showNoDate)
                    _button(context, title: "No Date", onTap: () {
                      setState(() {
                        selected = 0;
                      });
                      _selectDate(date: EmpStrConst.noDate);
                    }, selected: selected == 0),
                  _button(context, title: "Today", onTap: () {
                    setState(() {
                      selected = 1;
                    });
                    _selectDate(date: currentDate.toString());
                  }, selected: selected == 1),
                  if (widget.showNextMonday)
                    _button(context, title: "Next Monday", onTap: () {
                      setState(() {
                        selected = 2;
                      });
                      _selectDate(
                        date: _getNextWeekday(currentDate, DateTime.monday),
                      );
                    }, selected: selected == 2),
                  if (widget.showNextTuesday)
                    _button(context, title: "Next Tuesday", onTap: () {
                      setState(() {
                        selected = 3;
                      });
                      _selectDate(
                        date: _getNextWeekday(currentDate, DateTime.tuesday),
                      );
                    }, selected: selected == 3),
                  if (widget.showNextWeek)
                    _button(context, title: "After 1 week", onTap: () {
                      setState(() {
                        selected = 4;
                      });
                      _selectDate(
                          date: currentDate.add(Duration(days: 7)).toString());
                    }, selected: selected == 4)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _controller.backward!();
                      });
                    },
                    child: Transform.flip(
                      flipX: true,
                      child: SvgPicture.asset(ImagePath.rightGreyArrow),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      headerString,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _controller.forward!();
                      });
                    },
                    child: SvgPicture.asset(ImagePath.rightGreyArrow),
                  )
                ],
              ),
              SfDateRangePicker(
                toggleDaySelection: true,
                controller: _controller,
                showNavigationArrow: true,
                initialDisplayDate: currentDate,
                selectionMode: DateRangePickerSelectionMode.single,
                headerHeight: 0,
                monthViewSettings:
                    const DateRangePickerMonthViewSettings(dayFormat: 'EEE'),
                minDate: widget.startDate,
                showActionButtons: false,
                // maxDate: widget.maxDate,
                onViewChanged: viewChanged,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  setState(() {
                    selectedDate = args.value as DateTime?;
                    if (selectedDate != null) {
                      currentSelectionStatus = selectedDate.toString();
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(context,
      {required String title, bool selected = false, VoidCallback? onTap}) {
    return FractionallySizedBox(
      widthFactor: 0.47,
      child: SizedBox(
        height: 36,
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            elevation: 0,
            backgroundColor: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: selected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
      ),
    );
  }

  void viewChanged(DateRangePickerViewChangedArgs args) {
    final DateTime visibleStartDate = args.visibleDateRange.startDate!;
    headerString = DateFormat('MMMM yyyy').format(visibleStartDate).toString();
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      setState(() {});
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class datePicker extends StatefulWidget {
  const datePicker(
      {super.key,
      required this.onSelectionChanged,
      required this.dateController});

  final dynamic onSelectionChanged;
  final dateController;

  @override
  State<datePicker> createState() => _datePickerState();
}

class _datePickerState extends State<datePicker> {
  final DateRangePickerController _controller = DateRangePickerController();

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      setState(() {
        widget.dateController.text =
            DateFormat('yyyy').format(args.value).toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    widget.dateController.text =
        DateFormat('').format(DateTime.now()).toString();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 8.33 * fem),
            padding: EdgeInsets.fromLTRB(
              12.5 * fem,
              6.5 * fem,
              6.5 * fem,
              12.5 * fem,
            ),
            decoration: BoxDecoration(
              color: const Color(0xfff9f9f9),
              borderRadius: BorderRadius.circular(20 * fem),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Icon(
                    Icons.date_range,
                    size: 20 * fem,
                  ),
                  SizedBox(width: 10.5 * fem),
                  Expanded(
                    child: TextFormField(
                      controller: widget.dateController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Year Passed Out *',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * ffem,
                          color: const Color(0xffdadbd8),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter passed out year.';
                        }
                        return null; // Return null to indicate no validation error.
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
            child: SfDateRangePicker(
                view: DateRangePickerView.decade,
                controller: _controller,
                onSelectionChanged: selectionChanged,
                allowViewNavigation: false,
                showActionButtons: true,
                initialDisplayDate: DateTime.now(),
                onSubmit: (val) {
                  widget.onSelectionChanged(val);
                }),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class datePicker extends StatefulWidget {
  const datePicker(
      {super.key, required this.dateController, required this.hintText});

  final dateController;
  final hintText;

  @override
  State<datePicker> createState() => _datePickerState();
}

class _datePickerState extends State<datePicker> {
  String ShowText = '';

  DateTime _selectedYear = DateTime.now();

  _selectYear(BuildContext context) async {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text('Select Year'),
            content: SizedBox(
              height: 300,
              width: 300,
              child: YearPicker(
                selectedDate: _selectedYear,
                firstDate: DateTime(1970),
                lastDate: DateTime.now(),
                onChanged: (DateTime val) {
                  setState(() {
                    _selectedYear = val;
                    ShowText = val.year.toString();
                    widget.dateController.text = val.year.toString();
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          );
        }));
  }

  @override
  void initState() {
    super.initState();
    ShowText = widget.hintText;

    // widget.dateController.text =
    //     DateFormat('yyyy').format(DateTime.now()).toString();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.33 * fem),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.5, horizontal: 12.5),
              child: GestureDetector(
                onTap: () {
                  _selectYear(context);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.date_range,
                      size: 20 * fem,
                    ),
                    SizedBox(width: 20.5 * fem),
                    Text(
                      ShowText, // Display selected date here
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.5 * ffem,
                        color: Color.fromARGB(255, 3, 3, 3),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

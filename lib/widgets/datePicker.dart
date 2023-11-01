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
                firstDate: DateTime(1970), // Specify the starting year
                lastDate: DateTime.now(), // Specify the ending year
                onChanged: (DateTime val) {
                  print(val.year);
                  setState(() {
                    _selectedYear = val;
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
    widget.dateController.text =
        DateFormat('yyyy').format(DateTime.now()).toString();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Column(
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
                children: [
                  Icon(
                    Icons.date_range,
                    size: 20 * fem,
                  ),
                  SizedBox(width: 10.5 * fem),
                  Text(
                    widget.dateController.text, // Display selected date here
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
    );
  }
}



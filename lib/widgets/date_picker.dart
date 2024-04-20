import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const DatePicker({
    Key? key,
    required this.initialDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tebtukan Tanggal',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.0),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            height: 40.0,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

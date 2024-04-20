import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeSelected;

  const TimePicker({
    Key? key,
    required this.initialTime,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      widget.onTimeSelected(_selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tentukan Waktu',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.0),
        GestureDetector(
          onTap: () => _selectTime(context),
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
              '${_selectedTime.hour}:${_selectedTime.minute}',
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

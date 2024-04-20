import 'package:flutter/material.dart';
import 'package:agenda_app/widgets/date_picker.dart';
import 'package:agenda_app/widgets/time_picker.dart';

class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({Key? key}) : super(key: key);

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Back',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Implementasi untuk tombol edit
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Implementasi untuk tombol hapus
            },
          ),
        ],
        backgroundColor: Colors.white38,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DatePicker(
              initialDate: _selectedDate,
              onDateSelected: (DateTime selectedDate) {
                setState(() {
                  _selectedDate = selectedDate;
                });
              },
            ),
            SizedBox(height: 16.0),
            TimePicker(
              initialTime: _selectedTime,
              onTimeSelected: (TimeOfDay selectedTime) {
                setState(() {
                  _selectedTime = selectedTime;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your note here...',
                border: OutlineInputBorder(),
              ),
              maxLines: null, 
            ),
          ],
        ),
      ),
    );
  }
}

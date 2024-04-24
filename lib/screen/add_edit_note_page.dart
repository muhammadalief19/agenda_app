import 'package:agenda_app/database/note_database.dart';
import 'package:agenda_app/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({super.key, this.agenda});
  final Note? agenda;

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isUpdate = false;

  @override
  void initState() {
    super.initState();

    if (widget.agenda != null) {
      final Note agenda = widget.agenda!;
      isUpdate = true;
      titleController.text = agenda.name;
      dateController.text = agenda.date;
      timeController.text = agenda.time;
      descriptionController.text = agenda.deskripsi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF91E0B1),
            Color(0xFF003C73),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: isUpdate
              ? const Text(
                  'Update Note',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const Text(
                  'Add Note',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
          centerTitle: true,
          backgroundColor: Colors.white38,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Title',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                  ),
                  readOnly: true,
                  onTap: selectedDate,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Time',
                    prefixIcon: Icon(Icons.access_time),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                  ),
                  readOnly: true,
                  onTap: selectedTime,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Description ',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: isUpdate ? updateData : createData,
                    child:
                        isUpdate ? const Text('Update') : const Text('Save')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createData() async {
    var uuid = Uuid();
    String title = titleController.text;
    String date = dateController.text;
    String time = timeController.text;
    String description = descriptionController.text;
    String agendaCode = uuid.v1();

    final Note note = Note(
        agendaCode: agendaCode,
        name: title,
        date: date,
        time: time,
        deskripsi: description,
        createdAt: DateTime.now());

    await NoteDatabase.instance.create(note);

    Navigator.pop(context);
  }

  Future<void> updateData() async {
    if (widget.agenda != null) {
      String title = titleController.text;
      String date = dateController.text;
      String time = timeController.text;
      String description = descriptionController.text;
      final Note agenda = Note(
        id: widget.agenda?.id,
        agendaCode: widget.agenda!.agendaCode,
        name: title,
        date: date,
        time: time,
        deskripsi: description,
        createdAt: DateTime.now(),
      );

      int update = await NoteDatabase.instance.updateNoteById(agenda);

      if (update > 0) {
        Navigator.pop(context);
      } else {
        debugPrint("Error");
      }
    }
  }

  Future<void> selectedDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1945),
        lastDate: DateTime(2500));
    if (picked != null) {
      setState(() {
        dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> selectedTime() async {
    TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      setState(() {
        timeController.text = "${picked.hour}:${picked.minute}:00";
      });

      debugPrint("${picked.hour}.${picked.minute}");
    }
  }
}

import 'package:agenda_app/service/note_services.dart';
import 'package:flutter/material.dart';

class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({super.key, this.agenda});
  final Map? agenda;

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
      final Map agenda = widget.agenda!;
      isUpdate = true;
      titleController.text = agenda["name"];
      dateController.text = agenda["date"];
      timeController.text = agenda["time"];
      descriptionController.text = agenda["deskripsi"];
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
                    labelText: 'Time',
                    prefixIcon: Icon(Icons.calendar_today),
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
    String title = titleController.text;
    String date = dateController.text;
    String time = timeController.text;
    String description = descriptionController.text;

    bool create = await NoteServices.createNote(title, date, time, description);

    if (create) {
      Navigator.pop(context);
    } else {
      debugPrint("Error");
    }
  }

  Future<void> updateData() async {
    if (widget.agenda != null) {
      final Map agenda = widget.agenda!;
      String title = titleController.text;
      String date = dateController.text;
      String time = timeController.text;
      String description = descriptionController.text;
      int id = agenda["id"];

      bool update =
          await NoteServices.updateAgenda(title, date, time, description, id);

      if (update) {
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

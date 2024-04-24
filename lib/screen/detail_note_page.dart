import 'package:agenda_app/database/note_database.dart';
import 'package:agenda_app/model/note_model.dart';
import 'package:agenda_app/screen/add_edit_note_page.dart';
import 'package:flutter/material.dart';

class DetailNotePage extends StatefulWidget {
  const DetailNotePage({super.key, required this.code});
  final String code;

  @override
  State<DetailNotePage> createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  late Note agenda = Note(
      agendaCode: "",
      name: "",
      date: "",
      time: "",
      deskripsi: "",
      createdAt: DateTime.now());

  void getData() async {
    final Note response =
        await NoteDatabase.instance.getNoteBycode(widget.code);

    setState(() {
      agenda = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
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
          title: const Text(
            'Detail Note List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white38,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Center(
                child: Text(
                  agenda.name,
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                '${agenda.date} - ${agenda.time}',
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                agenda.deskripsi,
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      final route = MaterialPageRoute(
                        builder: (context) => AddEditNotePage(
                          agenda: agenda,
                        ),
                      );
                      await Navigator.push(context, route);
                      getData();
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      int delete = await NoteDatabase.instance
                          .deleteNoteById(agenda.id!);

                      if (delete > 0) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

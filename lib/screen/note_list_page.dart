import 'package:agenda_app/screen/add_edit_note_page.dart';
import 'package:agenda_app/screen/detail_note_page.dart';
import 'package:flutter/material.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Note List App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white38,
      ),
      body: const Center(
        child: Text(
          "Belum Ada Agenda",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final route = MaterialPageRoute(
            builder: (context) => DetailNotePage(),
          );
          await Navigator.push(context, route);
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        backgroundColor: Colors.white12,
        foregroundColor: Colors.white,
        child: const Icon(Icons.note_add_outlined),
      ),
    );
  }
}

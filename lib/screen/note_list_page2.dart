import 'package:agenda_app/database/note_database.dart';
import 'package:agenda_app/model/note_model.dart';
import 'package:agenda_app/screen/add_edit_note_page.dart';
import 'package:agenda_app/screen/detail_note_page.dart';
import 'package:agenda_app/widgets/note_tile.dart';
import 'package:flutter/material.dart';

class NoteListPage2 extends StatefulWidget {
  const NoteListPage2({Key? key}) : super(key: key);

  @override
  State<NoteListPage2> createState() => _NoteListPage2State();
}

class _NoteListPage2State extends State<NoteListPage2> {
  late List<Note> agendas = [];
  bool isLoading = true;

  Future<void> refreshData() async {
    agendas = await NoteDatabase.instance.getAllNotes();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(145, 224, 177, 0.78), // Warna pertama
              Color.fromRGBO(0, 60, 115, 0.73), // Warna kedua
            ],
            stops: [0.78, 0.73], // Lokasi warna dalam gradien
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Visibility(
          visible: isLoading,
          replacement: RefreshIndicator(
            onRefresh: refreshData,
            child: Visibility(
              visible: agendas.isNotEmpty,
              replacement: const Center(
                child: Text("Belum Ada Agenda"),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                  itemCount: agendas.length,
                  itemBuilder: (context, index) {
                    final Note agenda = agendas[index];

                    return GestureDetector(
                      onTap: () async {
                        final route = MaterialPageRoute(
                          builder: (context) => DetailNotePage(
                            code: agenda.agendaCode,
                          ),
                        );
                        await Navigator.push(context, route);
                        refreshData();
                      },
                      child: Card(
                        color: Color.fromARGB(148, 41, 87, 101),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: NoteTile(agenda: agenda, index: index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final route = MaterialPageRoute(
            builder: (context) => const AddEditNotePage(),
          );
          await Navigator.push(context, route);
          refreshData();
        },
        backgroundColor: const Color(0xFFB6B6B6), // Warna latar belakang
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Membuat tombol bulat
          side: const BorderSide(
            color: Color(0xFFC1C1C1), // Warna border
            width: 3.0, // Ketebalan border
          ),
        ),
      ),
    );
  }
}

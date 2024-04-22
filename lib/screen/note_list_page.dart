import 'package:agenda_app/screen/add_edit_note_page.dart';
import 'package:agenda_app/screen/detail_note_page.dart';
import 'package:agenda_app/service/note_services.dart';
import 'package:agenda_app/widgets/note_tile.dart';
import 'package:flutter/material.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  List agendas = [];
  bool isLoading = true;

  Future<void> refreshData() async {
    final response = await NoteServices.getNoteAll();
    if (response != null) {
      setState(() {
        agendas = response;
      });
      setState(() {
        isLoading = false;
      });
    }
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
      body: Visibility(
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
                  final agenda = agendas[index] as Map;

                  return GestureDetector(
                    onTap: () async {
                      final route = MaterialPageRoute(
                        builder: (context) => DetailNotePage(
                          code: agenda["agenda_code"],
                        ),
                      );
                      await Navigator.push(context, route);
                      refreshData();
                    },
                    child: Card(
                      color: Color.fromARGB(148, 41, 87, 101),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: NoteTile(agenda: agenda, index: index)),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final route = MaterialPageRoute(
            builder: (context) => const AddEditNotePage(),
          );
          await Navigator.push(context, route);
          refreshData();
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

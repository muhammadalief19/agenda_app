import 'package:agenda_app/screen/note_list_page.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda App',
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF91B1E0),
              Color(0xFF003C73),
            ],
          ),
        ),
        child: const NoteListPage(),
      ),
    );
  }
}

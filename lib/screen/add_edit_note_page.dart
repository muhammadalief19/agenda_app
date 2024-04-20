import 'package:flutter/material.dart';

class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({Key? key}) : super(key: key);

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
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

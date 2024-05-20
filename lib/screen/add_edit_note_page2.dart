import 'package:flutter/material.dart';

class AddEditNotePage2 extends StatefulWidget {
  const AddEditNotePage2({Key? key}) : super(key: key);

  @override
  State<AddEditNotePage2> createState() => _AddEditNotePage2State();
}

class _AddEditNotePage2State extends State<AddEditNotePage2> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isUpdate = false;

  String reminderDate = '';
  String reminderTime = '';

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
          actions: [
            IconButton(
              onPressed: () {
                // Tambahkan fungsi untuk menyimpan catatan di sini
              },
              icon: const Icon(Icons.check),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'add_reminder') {
                  _showAddReminderModal(context); // Menampilkan modal ketika dipilih
                } else if (value == 'delete') {
                  _showDeleteConfirmationDialog(context); // Menampilkan dialog konfirmasi penghapusan
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'add_reminder',
                  child: Text('Add Reminder'),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (reminderDate.isNotEmpty && reminderTime.isNotEmpty)
                  Row(
                    children: [
                      Icon(Icons.notifications),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reminderDate,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              reminderTime,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16.0),
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
                  controller: descriptionController,
                  maxLines: 20, // 550 / 48 = 11.45 (Dibulatkan ke 12)
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddReminderModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    reminderDate = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Masukkan Tanggal',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    reminderTime = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Masukkan Jam',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Batal'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Tambahkan fungsi untuk menyimpan reminder di sini
                    },
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Penghapusan'),
          content: const Text('Apakah Anda yakin untuk menghapus catatan ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                // Tambahkan fungsi untuk menghapus catatan di sini
                Navigator.pop(context);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}

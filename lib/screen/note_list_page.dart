import 'package:flutter/material.dart';
import 'package:agenda_app/screen/add_edit_note_page2.dart';
import 'package:agenda_app/screen/detail_note_page.dart';
import 'package:agenda_app/widgets/note_tile.dart';
import 'package:agenda_app/model/note_model.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  late List<Note> agendas = [];
  bool isLoading = true;

  // Contoh data pengingat statis
  final List<Map<String, String>> reminders = [
    {'title': 'Reminder 1', 'date': '2024-06-01'},
    {'title': 'Reminder 2', 'date': '2024-06-15'},
  ];

  Future<void> refreshData() async {
    // Contoh tanpa database
    await Future.delayed(Duration(seconds: 1)); // Simulasi pengambilan data

    setState(() {
      isLoading = false;
      // agendas = ... // Data agenda seharusnya diisi di sini
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFEFFC6),
              border: Border.all(color: Color(0xFFAEAEAE)),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Selamat datang di "Note with Reminder"!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Apa itu "Note with Reminder"?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      '"Note with Reminder" adalah aplikasi yang memungkinkan Anda membuat catatan dan mengatur pengingat untuk memastikan Anda tidak ketinggalan hal penting.'),
                  SizedBox(height: 10),
                  Text(
                    'Cara Menggunakan Aplikasi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      '1. Membuat Catatan Baru\n- Tekan tombol dokumen tambah di layar utama aplikasi.\n- Tuliskan judul dan isi deskripsi catatan Anda.\n- Jangan lupa harus menginputkan waktu dan tanggal yang akan mendatang.'),
                  Text(
                      '2. Menetapkan Pengingat\n- Pada halaman pembuatan atau pengeditan catatan harus menginputkan waktu dan tanggal yang tepat.'),
                  Text(
                      '3. Manajemen Catatan\n- Edit, hapus, atau salin catatan sesuai kebutuhan Anda.\n- Gunakan label atau folder untuk mengorganisasi catatan Anda.'),
                  Text(
                      '4. Sinkronisasi dan Backup\n- Hubungkan aplikasi dengan akun cloud Anda untuk sinkronisasi data.\n- Pastikan untuk melakukan backup data secara teratur untuk menghindari kehilangan.'),
                  Text(
                      '5. Pengaturan Aplikasi\n- Akses pengaturan aplikasi untuk menyesuaikan preferensi Anda.\n- Ubah tema, notifikasi, atau bahasa aplikasi sesuai keinginan.'),
                  Text(
                      '6. Dukungan dan Bantuan\n- Jika Anda mengalami masalah atau memiliki pertanyaan, hubungi tim dukungan pelanggan kami melalui menu bantuan di aplikasi.'),
                  SizedBox(height: 10),
                  Text(
                    'Kebijakan Privasi dan Keamanan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Kami memprioritaskan keamanan dan privasi data pengguna. Silakan baca kebijakan privasi kami untuk informasi lebih lanjut.'),
                  SizedBox(height: 10),
                  Text(
                    'Tentang Kami',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      '"Note with Reminder" dikembangkan oleh [Nama Perusahaan]. Kami berkomitmen untuk menyediakan pengalaman pengguna terbaik.'),
                  Text(
                      'Versi Aplikasi\nVersi Aplikasi: [Nomor Versi]\nTerakhir Diperbarui: [Tanggal Pembaruan Terakhir]'),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showReminderList(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification List'),
          content: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFEFFC6),
              border: Border.all(color: Color(0xFFAEAEAE)),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: reminders.map((reminder) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(reminder['title']!),
                        Text(reminder['date']!),
                      ],
                    ),
                    Divider(color: Colors.grey),
                  ],
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
        leading: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => _showInfoDialog(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_alert_outlined),
            onPressed: () => _showReminderList(context),
          ),
        ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final route = MaterialPageRoute(
            builder: (context) => const AddEditNotePage2(),
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

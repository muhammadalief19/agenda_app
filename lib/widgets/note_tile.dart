import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({super.key, required this.agenda, required this.index});
  final Map agenda;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(187, 73, 162, 98),
        child: Text(
          '${index + 1}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        agenda["name"],
        style: const TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      subtitle: Text(
        '${agenda["date"]} ${agenda["time"]}',
        style: const TextStyle(
            fontSize: 13.0, fontWeight: FontWeight.w400, color: Colors.white),
      ),
    );
  }
}

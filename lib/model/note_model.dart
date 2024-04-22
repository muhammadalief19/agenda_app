class NoteFields {
  static String id = 'id';
  static String agendaCode = 'agenda_code';
  static String name = 'name';
  static String date = 'date';
  static String time = 'time';
  static String deskripsi = 'deskripsi';
  static String createdAt = 'created_at';
  static String updatedAt = 'updated_at';
}

class Note {
  final int? id;
  final String? agendaCode;
  final String name;
  final String date;
  final String time;
  final String deskripsi;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Note(
      {this.id,
      this.agendaCode,
      required this.name,
      required this.date,
      required this.time,
      required this.deskripsi,
      this.createdAt,
      this.updatedAt});

  static Note fromJson(Map<String, Object?> json) {
    return Note(
      id: json[NoteFields.id] as int,
      name: json[NoteFields.name] as String,
      date: json[NoteFields.date] as String,
      time: json[NoteFields.time] as String,
      deskripsi: json[NoteFields.deskripsi] as String,
      createdAt: DateTime.parse(json[NoteFields.createdAt] as String),
      updatedAt: DateTime.parse(json[NoteFields.updatedAt] as String),
    );
  }

  Map<String, Object?> toJson() => {
        NoteFields.name: name,
        NoteFields.date: date,
        NoteFields.time: time,
        NoteFields.deskripsi: deskripsi,
      };
}

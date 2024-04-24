const String tableNote = "notes";

class NoteFields {
  static String id = 'id';
  static String agendaCode = 'agenda_code';
  static String name = 'name';
  static String date = 'date';
  static String time = 'time';
  static String deskripsi = 'deskripsi';
  static String createdAt = 'created_at';
}

class Note {
  final int? id;
  final String agendaCode;
  final String name;
  final String date;
  final String time;
  final String deskripsi;
  final DateTime createdAt;

  Note({
    this.id,
    required this.agendaCode,
    required this.name,
    required this.date,
    required this.time,
    required this.deskripsi,
    required this.createdAt,
  });

  Note copy(
      {int? id,
      String? agendaCode,
      String? name,
      String? date,
      String? time,
      String? deskripsi,
      DateTime? createdAt}) {
    return Note(
        id: id,
        agendaCode: agendaCode ?? this.agendaCode,
        name: name ?? this.name,
        date: date ?? this.date,
        time: time ?? this.time,
        deskripsi: deskripsi ?? this.deskripsi,
        createdAt: createdAt ?? this.createdAt);
  }

  static Note fromJson(Map<String, Object?> json) {
    return Note(
      id: json[NoteFields.id] as int,
      agendaCode: json[NoteFields.agendaCode] as String,
      name: json[NoteFields.name] as String,
      date: json[NoteFields.date] as String,
      time: json[NoteFields.time] as String,
      deskripsi: json[NoteFields.deskripsi] as String,
      createdAt: DateTime.parse(json[NoteFields.createdAt] as String),
    );
  }

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.agendaCode: agendaCode,
        NoteFields.name: name,
        NoteFields.date: date,
        NoteFields.time: time,
        NoteFields.deskripsi: deskripsi,
        NoteFields.createdAt: createdAt.toIso8601String()
      };
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note extends Equatable {
  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.tags,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final List<String> tags;

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    List<String>? tags,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [id, title, content, createdAt, tags];
}

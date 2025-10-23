import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_jot/features/app/utils/timestamp_converter.dart';
import 'package:dev_jot/features/notes/domain/models/checklist_item.dart';
import 'package:dev_jot/features/notes/domain/models/note_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable(explicitToJson: true)
class Note extends Equatable {
  const Note({
    required this.title,
    required this.noteType,
    this.content = '',
    this.createdAt,
    this.tags = const [],
    this.id = '',
    this.language,
    this.checkListItems = const [],
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  @JsonKey(includeToJson: false)
  final String id;
  final String title;
  final String content;
  @TimestampConverter()
  final DateTime? createdAt;
  final List<String> tags;
  final String? language;
  final NoteType noteType;
  final List<CheckListItem> checkListItems;

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    List<String>? tags,
    String? language,
    NoteType? noteType,
    List<CheckListItem>? checkListItems,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
      language: language ?? this.language,
      noteType: noteType ?? this.noteType,
      checkListItems: checkListItems ?? this.checkListItems,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    content,
    createdAt,
    tags,
    language,
    noteType,
    checkListItems,
  ];
}

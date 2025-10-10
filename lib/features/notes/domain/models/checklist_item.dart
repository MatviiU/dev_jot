import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checklist_item.g.dart';

@JsonSerializable()
class CheckListItem extends Equatable {
  const CheckListItem({
    required this.id,
    required this.text,
    this.isChecked = false,
  });

  factory CheckListItem.fromJson(Map<String, dynamic> json) =>
      _$CheckListItemFromJson(json);

  final String id;
  final String text;
  final bool isChecked;

  Map<String, dynamic> toJson() => _$CheckListItemToJson(this);

  CheckListItem copyWith({String? id, String? text, bool? isChecked}) {
    return CheckListItem(
      id: id ?? this.id,
      text: text ?? this.text,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  List<Object?> get props => [id, text, isChecked];
}

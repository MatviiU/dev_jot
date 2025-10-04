import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tip.g.dart';

@JsonSerializable()
class Tip extends Equatable {
  const Tip({required this.id, required this.text});

  factory Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);

  final String id;
  final String text;

  Map<String, dynamic> toJson() => _$TipToJson(this);

  Tip copyWith({String? id, String? text}) {
    return Tip(id: id ?? this.id, text: text ?? this.text);
  }

  @override
  List<Object?> get props => [id, text];
}

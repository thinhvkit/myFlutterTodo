import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

@entity
class Task extends Equatable {
  @primaryKey
  final String id;
  final String name;

  @JsonKey(ignore: true)
  final bool complete;

  const Task({required this.id, this.name = '', this.complete = false});

  Task copyWith({required bool complete, String? id, String? name}) {
    return Task(
      name: name ?? this.name,
      complete: complete,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [id, name, complete];

  @override
  bool get stringify => true;
}

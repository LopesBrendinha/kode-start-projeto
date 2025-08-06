import 'dart:convert';
import 'package:collection/collection.dart';

class PaginatedCharacters {
  final Info info;
  final List<Result> results;

  PaginatedCharacters({
    required this.info,
    required this.results,
  });

  PaginatedCharacters copyWith({
    Info? info,
    List<Result>? results,
  }) {
    return PaginatedCharacters(
      info: info ?? this.info,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'info': info.toMap(),
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory PaginatedCharacters.fromMap(Map<String, dynamic> map) {
    return PaginatedCharacters(
      info: Info.fromMap(map['info'] as Map<String, dynamic>),
      results: List<Result>.from(
        (map['results'] as List<dynamic>)
            .map((x) => Result.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginatedCharacters.fromJson(String source) =>
      PaginatedCharacters.fromMap(json.decode(source));

  @override
  String toString() => 'PaginatedCharacters(info: $info, results: $results)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaginatedCharacters &&
        other.info == info &&
        const ListEquality().equals(other.results, results);
  }

  @override
  int get hashCode => info.hashCode ^ results.hashCode;
}

class Info {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  Info({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  Info copyWith({
    int? count,
    int? pages,
    String? next,
    String? prev,
  }) {
    return Info(
      count: count ?? this.count,
      pages: pages ?? this.pages,
      next: next ?? this.next,
      prev: prev ?? this.prev,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'pages': pages,
      'next': next,
      'prev': prev,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      count: map['count'] as int,
      pages: map['pages'] as int,
      next: map['next'] as String?,
      prev: map['prev'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) => Info.fromMap(json.decode(source));

  @override
  String toString() => 'Info(count: $count, pages: $pages, next: $next, prev: $prev)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Info &&
        other.count == count &&
        other.pages == pages &&
        other.next == next &&
        other.prev == prev;
  }

  @override
  int get hashCode => count.hashCode ^ pages.hashCode ^ next.hashCode ^ prev.hashCode;
}

class Result {
  final int id;
  final String name;

  Result({
    required this.id,
    required this.name,
  });

  Result copyWith({
    int? id,
    String? name,
  }) {
    return Result(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source));

  @override
  String toString() => 'Result(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Result && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:voidlord/model/tono_book_mark.dart';
import 'package:voidlord/model/tono_book_note.dart';
import 'package:voidlord/tono_reader/model/base/tono_location.dart';

class BookLocationConverter extends TypeConverter<TonoLocation?, String> {
  @override
  TonoLocation? decode(String databaseValue) {
    if (databaseValue == "") {
      return null;
    }
    return TonoLocation.fromMap(jsonDecode(databaseValue));
  }

  @override
  String encode(TonoLocation? value) {
    if (value == null) {
      return "";
    }
    return jsonEncode(value.toJson());
  }
}

class BookMarkConverter extends TypeConverter<List<TonoBookMark>, String> {
  @override
  List<TonoBookMark> decode(String databaseValue) {
    return (json.decode(databaseValue) as List<dynamic>)
        .map((e) => TonoBookMark.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  String encode(List<TonoBookMark> value) {
    return json.encode(value.map((e) => e.toJson()).toList());
  }
}

class BookNoteConverter extends TypeConverter<List<TonoBookNote>, String> {
  @override
  List<TonoBookNote> decode(String databaseValue) {
    return (json.decode(databaseValue) as List<dynamic>)
        .map((e) => TonoBookNote.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  String encode(List<TonoBookNote> value) {
    return json.encode(value.map((e) => e.toJson()).toList());
  }
}

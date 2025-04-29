import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voidlord/tono_reader/model/base/tono_location.dart';
import 'package:voidlord/tono_reader/model/base/tono_note.dart';

class TonoUserDataProvider extends GetxController {
  List<TonoLocation> bookmarks = [];
  List<TonoNote> notes = [];
  Future init() async {}
  Future initFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var bookMarksRaw = prefs.getStringList("bookmarks");
    if (bookMarksRaw != null) {
      for (var bookMark in bookMarksRaw) {
        bookmarks.add(TonoLocation.fromMap(json.decode(bookMark)));
      }
    }
    var notesRaw = prefs.getStringList("notes");
    if (notesRaw != null) {
      for (var note in notesRaw) {
        notes.add(TonoNote.fromMap(json.decode(note)));
      }
    }
  }

  Future saveToLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("bookmarks",
        bookmarks.map((e) => json.encoder.convert(e.toMap())).toList());
    prefs.setStringList(
        "notes", notes.map((e) => json.encoder.convert(e.toMap())).toList());
  }

  bool isMarked(TonoLocation location) {
    return bookmarks.firstWhereOrNull((e) =>
                e.elementIndex == location.elementIndex &&
                e.xhtmlIndex == location.xhtmlIndex) !=
            null ||
        notes.firstWhereOrNull((e) =>
                e.location.elementIndex == location.elementIndex &&
                e.location.xhtmlIndex == location.elementIndex) !=
            null;
  }
}

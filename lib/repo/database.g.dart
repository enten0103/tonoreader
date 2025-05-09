// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BookReaderInfoDao? _bookInfoDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BookReaderInfo` (`bookHash` TEXT NOT NULL, `histroy` TEXT, `bookMarks` TEXT NOT NULL, `bookNotes` TEXT NOT NULL, PRIMARY KEY (`bookHash`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BookReaderInfoDao get bookInfoDao {
    return _bookInfoDaoInstance ??=
        _$BookReaderInfoDao(database, changeListener);
  }
}

class _$BookReaderInfoDao extends BookReaderInfoDao {
  _$BookReaderInfoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bookReaderInfoInsertionAdapter = InsertionAdapter(
            database,
            'BookReaderInfo',
            (BookReaderInfo item) => <String, Object?>{
                  'bookHash': item.bookHash,
                  'histroy': _bookLocationConverter.encode(item.histroy),
                  'bookMarks': _bookMarkConverter.encode(item.bookMarks),
                  'bookNotes': _bookNoteConverter.encode(item.bookNotes)
                }),
        _bookReaderInfoUpdateAdapter = UpdateAdapter(
            database,
            'BookReaderInfo',
            ['bookHash'],
            (BookReaderInfo item) => <String, Object?>{
                  'bookHash': item.bookHash,
                  'histroy': _bookLocationConverter.encode(item.histroy),
                  'bookMarks': _bookMarkConverter.encode(item.bookMarks),
                  'bookNotes': _bookNoteConverter.encode(item.bookNotes)
                }),
        _bookReaderInfoDeletionAdapter = DeletionAdapter(
            database,
            'BookReaderInfo',
            ['bookHash'],
            (BookReaderInfo item) => <String, Object?>{
                  'bookHash': item.bookHash,
                  'histroy': _bookLocationConverter.encode(item.histroy),
                  'bookMarks': _bookMarkConverter.encode(item.bookMarks),
                  'bookNotes': _bookNoteConverter.encode(item.bookNotes)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BookReaderInfo> _bookReaderInfoInsertionAdapter;

  final UpdateAdapter<BookReaderInfo> _bookReaderInfoUpdateAdapter;

  final DeletionAdapter<BookReaderInfo> _bookReaderInfoDeletionAdapter;

  @override
  Future<BookReaderInfo?> findByBookHash(String bookHash) async {
    return _queryAdapter.query(
        'SELECT * FROM BookReaderInfo WHERE bookHash = ?1',
        mapper: (Map<String, Object?> row) => BookReaderInfo(
            bookHash: row['bookHash'] as String,
            histroy: _bookLocationConverter.decode(row['histroy'] as String),
            bookMarks: _bookMarkConverter.decode(row['bookMarks'] as String),
            bookNotes: _bookNoteConverter.decode(row['bookNotes'] as String)),
        arguments: [bookHash]);
  }

  @override
  Future<void> insertBookReaderInfo(BookReaderInfo bookReaderInfo) async {
    await _bookReaderInfoInsertionAdapter.insert(
        bookReaderInfo, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateBookReaderInfo(BookReaderInfo bookReaderInfo) async {
    await _bookReaderInfoUpdateAdapter.update(
        bookReaderInfo, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBookReaderInfo(BookReaderInfo bookReaderInfo) async {
    await _bookReaderInfoDeletionAdapter.delete(bookReaderInfo);
  }
}

// ignore_for_file: unused_element
final _bookNoteConverter = BookNoteConverter();
final _bookMarkConverter = BookMarkConverter();
final _bookLocationConverter = BookLocationConverter();

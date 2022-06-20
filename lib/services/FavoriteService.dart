import 'package:film_fan/models/Favorite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesDatabase {
  static final FavoritesDatabase instance = FavoritesDatabase._init();

  late Database _database;
  FavoritesDatabase._init();

  Future<Database> get database async {
    _database = await _initDB('favorites.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future deleteTable() async {
    final db = await database;
    final result = db.delete(tableFavorites);
    return result;
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'DOUBLE NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableFavorites ( 
  ${FavoriteFields.id} $idType, 
  ${FavoriteFields.title} $textType,
  ${FavoriteFields.release_date} $textType,
  ${FavoriteFields.vote_average} $textType,
  ${FavoriteFields.movieId} $textType,
  ${FavoriteFields.poster_path} $textType)
''');
  }

  Future<int> create(Favorite favorite) async {
    final db = await instance.database;

    final result = await db.insert(tableFavorites, favorite.toJson());
    return result;
  }

  Future<Favorite> readFavoriteMovie(int movieId) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFavorites,
      columns: FavoriteFields.values,
      where: '${FavoriteFields.movieId} = ?',
      whereArgs: [movieId],
    );

    if (maps.isNotEmpty) {
      return Favorite.fromJson(maps.first);
    } else {
      throw Exception('ID $movieId not found');
    }
  }

  Future<List<Favorite>> readAllFavorites() async {
    final db = await instance.database;

    const orderBy = '${FavoriteFields.id} DESC';
    final result = await db.query(tableFavorites, orderBy: orderBy);

    return result.map((json) => Favorite.fromJson(json)).toList();
  }

  Future<int> update(Favorite favorite) async {
    final db = await instance.database;

    return db.update(
      tableFavorites,
      favorite.toJson(),
      where: '${FavoriteFields.id} = ?',
      whereArgs: [favorite.id],
    );
  }

  Future<int> delete(String movieId) async {
    final db = await instance.database;

    return await db.delete(
      tableFavorites,
      where: '${FavoriteFields.movieId} = ?',
      whereArgs: [movieId],
    );
  }

  // This method return an object if passed uuid exists
  Future<Favorite> findByMovieId(String movieId) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFavorites,
      columns: FavoriteFields.values,
      where: '${FavoriteFields.movieId} = ?',
      whereArgs: [movieId],
    );

    if (maps.isNotEmpty) {
      return Favorite.fromJson(maps.first);
    } else {
      throw Exception('ID $movieId not found');
    }
  }

  // this method return True if passed uuid as args is in the db(sql)
  Future<bool> findByDbMovieId(String movieId) async {
    final db = await instance.database;
    final maps = await db.query(
      tableFavorites,
      columns: FavoriteFields.values,
      where: '${FavoriteFields.id} = ?',
      whereArgs: [movieId],
    );
    if (maps.isNotEmpty) return true;
    return false;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DB {
  static Future<sql.Database> openDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, "kaikebarbearia.db"),
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT NOT NULL, price REAL, quantity INTEGER, cost_value REAL, profit_value REAL NOT NULL)");

        db.execute(
            "CREATE TABLE sales (id INTEGER PRIMARY KEY, date_sale TEXT NOT NULL, value_total REAL NOT NULL, profit_value_total REAL)"); // sales - Vendas

        db.execute(
            "CREATE TABLE items_sales (id INTEGER PRIMARY KEY, price_product REAL NOT NULL, product_id INTEGER NOT NULL, sale_id INTEGER NOT NULL, FOREIGN KEY (product_id) REFERENCES products(id), ON DELETE SET NULL, FOREIGN KEY (sale_id) REFERENCES sales(id) ON DELETE CASCADE)");

        
      },
      version: 1,
    );
  }
}

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DB {
  static Future<sql.Database> openDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, "kaikebarbearia.db"),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT NOT NULL, sale_value REAL, quantity INTEGER, cost_value REAL, profit_value REAL NOT NULL)",
        );
       
        db.execute(
          "CREATE TABLE clients (id INTEGER PRIMARY KEY, name TEXT NOT NULL, phone TEXT)",
        );

        db.execute(
          "CREATE TABLE sales (id INTEGER PRIMARY KEY, date_sale TEXT NOT NULL, profit_value_product REAL NOT NULL, profit_value_total REAL, discount REAL NOT NULL, client_id INTEGER, FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL)",
        ); // sales - Vendas

        db.execute(
          "CREATE TABLE items_sales (id INTEGER PRIMARY KEY, quantity_items INTEGER, sub_total REAL NOT NULL, price_product REAL NOT NULL, lucro_product REAL NOT NULL, product_id INTEGER NOT NULL, sale_id INTEGER NOT NULL, FOREIGN KEY (product_id) REFERENCES products(id), ON DELETE SET NULL, FOREIGN KEY (sale_id) REFERENCES sales(id) ON DELETE CASCADE)",
        );

        db.execute("CREATE TABLE payments_sales (id INTEGER PRIMARY KEY, species TEXT, sale_id INTEGER, FOREIGN KEY (sale_id) REFERENCES sales(id) ON DELETE CASCADE)");

        db.execute(
          "CREATE TABLE services (id INTEGER PRIMARY KEY, description TEXT NOT NULL, price REAL NOT NULL)",
        );

        db.execute(
          "CREATE TABLE provision_of_services (id INTEGER PRIMARY KEY, date TEXT NOT NULL, time TEXT NOT NULL, client_id INTEGER, service_id INTEGER, FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE, FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL)",
        );

        db.execute("CREATE TABLE payments_services (id INTEGER PRIMARY KEY, species TEXT, service_id INTEGER, FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE)");

        db.execute(
          "CREATE TABLE spending (id INTEGER PRIMARY KEY, name_product TEXT NOT NULL, price REAL NOT NULL, quantity INTEGER NOT NULL, date TEXT NOT NULL)", // spending = gastos da barbearia
        );
      },
      version: 1,
    );
  }
}

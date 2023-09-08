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
          "CREATE TABLE clients (id INTEGER PRIMARY KEY, name TEXT NOT NULL, phone TEXT, address TEXT)",
        );

        db.execute(
          "CREATE TABLE sales (id INTEGER PRIMARY KEY, date_sale TEXT NOT NULL, value_total REAL, profit_value_total REAL, discount REAL NOT NULL, client_id INTEGER NULL, FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL)",
        ); // sales - Vendas

        db.execute(
            "CREATE TABLE items_sales (id INTEGER PRIMARY KEY, quantity INTEGER, sub_total REAL NOT NULL, price_product REAL NOT NULL, profit_product REAL NOT NULL, sub_profit_product REAL NOT NULL, product_id INTEGER NOT NULL, sale_id INTEGER NOT NULL, FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL, FOREIGN KEY (sale_id) REFERENCES sales(id) ON DELETE CASCADE )");

        db.execute(
            "CREATE TABLE payments_sales (id INTEGER PRIMARY KEY, specie TEXT, amount_paid REAL, date_payment TEXT, sale_id INTEGER, FOREIGN KEY (sale_id) REFERENCES sales(id) ON DELETE CASCADE)");

        db.execute(
          "CREATE TABLE services (id INTEGER PRIMARY KEY, description TEXT NOT NULL, price REAL NOT NULL)",
        );

        db.execute(
          "CREATE TABLE provision_of_services (id INTEGER PRIMARY KEY, date_service TEXT NOT NULL, value_total REAL NOT NULL, discount REAL, client_id INTEGER, service_id INTEGER, FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL)",
        );

         db.execute(
            "CREATE TABLE items_services (id INTEGER PRIMARY KEY, price_service REAL, time_service TEXT NOT NULL, service_id INTEGER NOT NULL, provision_of_service_id INTEGER NOT NULL, FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE SET NULL, FOREIGN KEY (provision_of_service_id) REFERENCES provision_of_services(id) ON DELETE CASCADE)");

        db.execute(
            "CREATE TABLE payments_services (id INTEGER PRIMARY KEY, specie TEXT, amount_paid REAL, date_payment TEXT, provision_of_service_id INTEGER NOT NULL, FOREIGN KEY (provision_of_service_id) REFERENCES provision_of_services(id) ON DELETE CASCADE)");

        db.execute(
          "CREATE TABLE expenses (id INTEGER PRIMARY KEY, name_product TEXT NOT NULL, price REAL NOT NULL, quantity INTEGER NOT NULL, date TEXT NOT NULL)", // Depesas da barbearia
        );
        db.execute(
          "CREATE TABLE personal_expenses (id INTEGER PRIMARY KEY, name_product TEXT NOT NULL, price REAL NOT NULL, quantity INTEGER NOT NULL, date TEXT NOT NULL)", // Depesas pessoais
        );
      },
      version: 1,
    );
  }
}

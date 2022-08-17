class SQLiteHelper {
  final String nameDatabase = 'boneclinicmsu.db';
  final int version = 1;
  final String tablDatabase = 'tableOrder';
  final String columnId = 'id';
  final String columnIdProduct = 'idProduct';
  final String columnName = 'name';
  final String columnPrice = 'price';
  final String columnAmount = 'Amount';
  final String columnSum = 'sum';

  SQLiteHelper() {
    initislDatabase();
  }

  Future<Null> initislDatabase() async {}
}

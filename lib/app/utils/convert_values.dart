import 'package:intl/intl.dart';

final NumberFormat numberFormat =
    NumberFormat.currency(locale: "pt_BR", symbol: "R\$");
final DateFormat dateFormat1 = DateFormat("dd/MM/yyyy", "pt_BR");
final DateFormat dateFormat2 = DateFormat("dd 'de' MMMM 'de' yyyy", "pt_BR");

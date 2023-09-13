DateTime convertStringToDateTime(String date) {
  int year = int.parse(date.toString().split("-")[0]);
  int month = int.parse(date.toString().split("-")[1]);
  int day = int.parse(date.toString().split("-")[2]);
  return DateTime(year, month, day);
}

String changeTheDateWriting(String date) {
  final splitDate = date.split("-");
  return "${splitDate[2]}/${splitDate[1]}/${splitDate[0]}";
}

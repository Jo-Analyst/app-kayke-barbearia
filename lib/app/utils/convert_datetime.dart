DateTime getDateSpedings(String date) {
    int year = int.parse(date.toString().split("/")[2]);
    int month = int.parse(date.toString().split("/")[1]);
    int day = int.parse(date.toString().split("/")[0]);
    return DateTime(year, month, day);
  }
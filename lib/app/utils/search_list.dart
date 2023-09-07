List<Map<String, dynamic>> itemsList = [];

List<Map<String, dynamic>> searchItems(
    String searchText, List<Map<String, dynamic>> items, String nameColumn) {
  if (searchText.isEmpty) {
    return itemsList = List.from(items);
  } else {
    return itemsList = items
        .where((item) => item[nameColumn]
            .toString()
            .trim()
            .toLowerCase()
            .contains(searchText.trim().toLowerCase()))
        .toList();
  }
}

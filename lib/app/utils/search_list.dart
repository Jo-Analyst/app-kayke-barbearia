List<Map<String, dynamic>> filteredList = [];

List<Map<String, dynamic>> searchItems(
    String searchText, List<Map<String, dynamic>> items, bool? isService) {
  if (searchText.isEmpty) {
    return filteredList = List.from(items);
  } else {
    return filteredList = items
        .where((item) => item[isService! ? "description" : 'name']
            .toString()
            .trim()
            .toLowerCase()
            .contains(searchText.trim().toLowerCase()))
        .toList();
  }
}

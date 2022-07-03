import 'package:movie/component/variable.dart';

class movie_data {
  static List<String> getSuggestions(String query) =>
      List.of(crawlingData).where((name) {
        final nameLower = name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
}

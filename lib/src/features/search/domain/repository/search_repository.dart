import '../../search.dart';

abstract class SearchRepository {
  Future<List<SearchEntity>> search(String query);
}

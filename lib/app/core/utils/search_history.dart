// search_history_manager.dart
import 'package:get_storage/get_storage.dart';

class SearchHistoryManager {
  // 1. Define the storage key and the storage instance
  static const String _searchHistoryKey = 'previous_searches';
  final GetStorage _box = GetStorage();

  // Define the maximum number of queries to store
  static const int _maxHistoryLength = 10;

  /// Retrieves the list of unique search queries from storage.
  /// The list is ordered from newest to oldest.
  List<String> getSearchHistory() {
    // Read the list from the storage box. If null, return an empty list.
    // We cast to List<dynamic> and then map to List<String>.
    final List<dynamic> storedList = _box.read(_searchHistoryKey) ?? [];
    return storedList.cast<String>();
  }

  /// Adds a new search query to the history list.
  /// It ensures the query is unique, moves it to the start, and limits the list size.
  ///
  /// Args:
  ///   query: The search string to add (e.g., "new laptop").
  void addQueryToHistory(String query) {
    if (query.trim().isEmpty) {
      return; // Do not store empty queries
    }

    // 1. Get the current list
    List<String> history = getSearchHistory();

    // Normalize the query (optional, but good practice for unique comparison)
    final String normalizedQuery = query.trim().toLowerCase();

    // 2. Remove duplicates (ensures uniqueness and moves existing to the top)
    // We use removeWhere to find and remove the matching case-insensitive query.
    history.removeWhere((item) => item.toLowerCase() == normalizedQuery);

    // 3. Add the new query to the front of the list (newest first)
    history.insert(0, query.trim());

    // 4. Limit the list size to the last 10 unique queries
    if (history.length > _maxHistoryLength) {
      // Keep only the first (newest) _maxHistoryLength items
      history = history.sublist(0, _maxHistoryLength);
    }

    // 5. Save the updated list back to GetStorage
    _box.write(_searchHistoryKey, history);
  }

  /// Clears the entire search history from storage.
  void clearHistory() {
    _box.remove(_searchHistoryKey);
  }
}

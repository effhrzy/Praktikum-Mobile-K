import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mikan/data/models/books.dart';

class BooksViewModel {
  final String apiKey;

  BooksViewModel(this.apiKey);

  Future<List<Book>> searchBooks(String query) async {
    final response = await http.get(
      Uri.https('www.googleapis.com', '/books/v1/volumes',
          {'q': query, 'key': apiKey}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Book> books = [];

      if (data['items'] != null) {
        for (var item in data['items']) {
          books.add(Book.fromJson(item));
        }
      }

      return books;
    } else {
      throw Exception('Failed to load books');
    }
  }
}

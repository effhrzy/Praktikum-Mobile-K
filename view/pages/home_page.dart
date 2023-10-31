// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mikan/viewmodels/books_view_model.dart';
import 'package:mikan/data/models/books.dart';
import 'package:mikan/view/widgets/bottom_nav_bar.dart';
import "package:mikan/view/widgets/webview.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final BooksViewModel _booksViewModel =
      BooksViewModel('AIzaSyBGSUu0FfPaCiO9qqlugJe6osVpzr2Pm3k');

  List<Book> _searchResults = [];

  Future<void> _updateSearchResults(String query) async {
    if (query.isNotEmpty) {
      final results = await _booksViewModel.searchBooks(query);

      setState(() {
        _searchResults = results;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  void _onResultTapped(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookWebView(book.url)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Search App'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200], // Background color for the search box
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for Books',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none, // Remove the default border
                ),
                onChanged: (query) {
                  // Call a function to update the results as the user types.
                  _updateSearchResults(query);
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final book = _searchResults[index];
                return GestureDetector(
                  onTap: () {
                    _onResultTapped(book);
                  },
                  child: ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    leading: Image.network(book.imageUrl),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

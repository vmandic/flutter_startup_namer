// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _savedWords = <String>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
          actions: [
            IconButton(
              onPressed: _pushedSaved,
              icon: const Icon(Icons.list),
              tooltip: "Saved Suggestion",
            )
          ],
          centerTitle: false,
        ),
        body: ListView.builder(
          itemBuilder: _listItemFn,
          padding: const EdgeInsets.all(16.0),
        ));
  }

  void _pushedSaved() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final tiles = _savedWords.map(
        (pair) {
          return ListTile(
            title: Text(
              pair,
              style: _biggerFont,
            ),
          );
        },
      );

      final divided = tiles.isNotEmpty
          ? ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList()
          : <Widget>[];

      return Scaffold(
        appBar: AppBar(
          title: const Text('Saved Suggestions'),
        ),
        body: ListView(children: divided),
      );
    }));
  }

  Widget _listItemFn(BuildContext context, int index) {
    if (index.isOdd) {
      return const Divider(); /*2*/
    }

    index = index ~/ 2; /*3*/
    if (index >= _suggestions.length) {
      _suggestions.addAll(generateWordPairs().take(10)); /*4*/
    }

    var wordToDisplay = _suggestions[index].asPascalCase;
    final alreadySaved = _savedWords.contains(wordToDisplay);

    var listTitle = ListTile(
      title: Text(wordToDisplay, style: _biggerFont),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
          semanticLabel: alreadySaved ? "Remove from saved" : "Save"),
      onTap: () => handleOnListTileTap(alreadySaved, wordToDisplay),
    );
    return listTitle;
  }

  void handleOnListTileTap(bool alreadySaved, String wordToDisplay) {
    setState(() {
      var _ = alreadySaved
          ? _savedWords.remove(wordToDisplay)
          : _savedWords.add(wordToDisplay);
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        home: const RandomWords(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ));
  }
}

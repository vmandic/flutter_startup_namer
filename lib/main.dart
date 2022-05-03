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
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: listItemFn,
      padding: const EdgeInsets.all(16.0),
    );
  }

  Widget listItemFn(BuildContext context, int index) {
    if (index.isOdd) {
      return const Divider(); /*2*/
    }

    index = index ~/ 2; /*3*/
    if (index >= _suggestions.length) {
      _suggestions.addAll(generateWordPairs().take(10)); /*4*/
    }

    var listTitle = ListTile(
        title: Text(_suggestions[index].asPascalCase, style: _biggerFont));

    return listTitle;
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Widget homeWidget = Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: const Center(
        child: RandomWords(),
      ));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Startup Name Generator', home: homeWidget);
  }
}

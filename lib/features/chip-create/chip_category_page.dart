import 'package:flutter/material.dart';

class ChipCategoryPage extends StatelessWidget {
  const ChipCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('category')),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //
              // Text('data'),
              _EntryView(),
            ],
          ),
        ),
      ),
    );
  }
}

enum _Entry {
  human,
  pet;

  factory _Entry.fromIndex(int i) => _Entry.values[i];

  String get title {
    switch (this) {
      case human:
        return 'aaa';
      case pet:
        return 'bbb';
    }
  }
}

class _EntryView extends StatelessWidget {
  const _EntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 280 / 202,
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/category_human.png'))),
        child: Column(
          children: [
            //
            Text('data'),
          ],
        ),
      ),
    );
  }
}

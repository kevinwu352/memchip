import 'package:flutter/material.dart';

class ChipCategoryPage extends StatelessWidget {
  const ChipCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('category')),
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          //
          // Text('data'),
          _EntryView(),
        ],
      ),
    );
  }
}

class _EntryView extends StatelessWidget {
  const _EntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [Image.asset('assets/images/create_human.png'), Text('data')]);
  }
}

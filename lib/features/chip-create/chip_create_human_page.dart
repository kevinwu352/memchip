import 'package:flutter/material.dart';
import 'chip_create_views.dart';

class ChipCreateHumanPage extends StatelessWidget {
  const ChipCreateHumanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Human')),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            sliver: SliverToBoxAdapter(child: SectionView(title: 'Add Image')),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            sliver: SliverToBoxAdapter(child: UploadView(images: [null, null])),
          ),

          // SliverGrid.builder(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 20,
          //     mainAxisSpacing: 20,
          //     childAspectRatio: 1,
          //   ),
          //   itemCount: 5,
          //   itemBuilder: (context, index) => Container(color: Colors.amber),
          // ),
          // SliverGrid.builder(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 20,
          //     mainAxisSpacing: 20,
          //     childAspectRatio: 1,
          //   ),
          //   itemCount: 5,
          //   itemBuilder: (context, index) => Container(color: Colors.green),
          // ),
        ],
      ),
    );
  }
}

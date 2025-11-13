import 'package:flutter/material.dart';
import '/pch.dart';

class PreviewedView extends StatelessWidget {
  const PreviewedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 0, 25, kSafeBot),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Image',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: MyColors.gray800),
                ),
                Text(
                  // 'Please choose one',
                  'Please choose one image from the following to create a holographic projection.',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: MyColors.gray500),
                ),
              ],
            ),
          ),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: GridView.builder(
                itemCount: 7,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) => Container(color: Colors.red),
              ),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: MyColors.orange400),
            onPressed: () {},
            child: Text('Confirm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

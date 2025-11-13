import 'package:flutter/material.dart';
import '/pch.dart';

class GeneratedView extends StatelessWidget {
  const GeneratedView({super.key, required this.url, required this.action});
  final String url;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 0, 25, kSafeBot),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 335,
              height: 405,
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.violet300, width: 12),
                borderRadius: BorderRadius.circular(35),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25 - 5),
                child: Container(color: Colors.green),
              ),
            ),
          ),

          Spacer(),

          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: MyColors.orange400),
            onPressed: action,
            child: Text('Confirm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

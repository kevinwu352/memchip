import 'package:flutter/material.dart';
import '/pch.dart';

class ActionView extends StatelessWidget {
  const ActionView({super.key, required this.info, required this.button, required this.doing, required this.action});
  final String info;
  final String button;
  final bool doing;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(60, 30, 60, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [MyColors.violet300, MyColors.violet300.withValues(alpha: 0.65)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 30,
        children: [
          Text(
            info,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: MyColors.white100),
            textAlign: TextAlign.center,
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: MyColors.orange400),
            onPressed: action,
            child: doing
                ? CircularProgressIndicator.adaptive(backgroundColor: MyColors.white100)
                : Text(button, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

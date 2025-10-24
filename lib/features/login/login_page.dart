import 'dart:async';
import 'package:flutter/material.dart';
import '/l10n/localizations.dart';
import '/theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailCtr = TextEditingController();
  final _codeCtr = TextEditingController();

  var _showClear = false;

  var _allValid = false;
  var _emailValid = false;

  int _countdown = 0;

  bool get _sendEnabled => _emailValid && _countdown <= 0;

  @override
  void dispose() {
    _emailCtr.dispose();
    _codeCtr.dispose();
    super.dispose();
  }

  void emailChanged(String value) {
    setState(() {
      _showClear = value.isNotEmpty;
      _emailValid = value.isNotEmpty;
      validate();
    });
  }

  void codeChanged(String value) {
    setState(() {
      validate();
    });
  }

  void validate() {
    _allValid = _emailCtr.text.isNotEmpty && _codeCtr.text.isNotEmpty;
  }

  void clearAction() {
    _emailCtr.clear();
    emailChanged('');
  }

  void sendAction() {
    setState(() {
      _countdown = 60;
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) {
        // print('tick: unmounted cancel');
        timer.cancel();
        return;
      }
      if (_countdown > 0) {
        // print('tick: $_countdown next');
        setState(() {
          _countdown -= 1;
        });
      } else {
        // print('tick: $_countdown cancel');
        timer.cancel();
      }
    });
  }

  void submitAction() {
    print('qwerty');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: Listener(
          onPointerDown: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 32),
                  Image.asset('assets/images/logo.png'),

                  SizedBox(height: 80),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppLocalizations.of(context)!.login_title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: MyColors.orange400),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppLocalizations.of(context)!.login_subtitle,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: MyColors.orange400),
                    ),
                  ),

                  SizedBox(height: 50),
                  TextFormField(
                    controller: _emailCtr,
                    onChanged: (value) => emailChanged(value),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    cursorColor: MyColors.gray800,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: AppLocalizations.of(context)!.login_email_caption,
                      labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: MyColors.gray800),
                      hintText: 'example@email.com',
                      hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray500),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.gray300, width: 2)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.violet200, width: 2)),
                      suffixIcon: _showClear
                          ? IconButton(
                              onPressed: () => clearAction(),
                              icon: Icon(Icons.cancel),
                              iconSize: 18,
                              color: MyColors.gray600,
                              focusNode: FocusNode(skipTraversal: true),
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: _codeCtr,
                    onChanged: (value) => codeChanged(value),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    cursorColor: MyColors.gray800,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.join,
                    onFieldSubmitted: (value) => FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: AppLocalizations.of(context)!.login_code_caption,
                      labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: MyColors.gray800),
                      hintText: '123456',
                      hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray500),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.gray300, width: 2)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.violet200, width: 2)),
                      suffixIcon: UnconstrainedBox(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            backgroundColor: MyColors.violet100,
                            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                            minimumSize: Size.zero,
                          ),
                          onPressed: _sendEnabled ? sendAction : null,
                          child: Text(AppLocalizations.of(context)!.login_code_send(_countdown)),
                        ),
                      ),
                    ),
                  ),

                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        backgroundColor: MyColors.violet300,
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      onPressed: _allValid ? submitAction : null,
                      child: Text(AppLocalizations.of(context)!.login_submit_caption),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

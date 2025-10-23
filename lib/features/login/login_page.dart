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

  var _showEmailClear = false;

  var _allValid = false;

  @override
  void dispose() {
    _emailCtr.dispose();
    _codeCtr.dispose();
    super.dispose();
  }

  void emailChanged(String value) {
    setState(() {
      _showEmailClear = value.isNotEmpty;
      _allValid = _formKey.currentState!.validate();
    });
  }

  void codeChanged(String value) {
    setState(() {
      _allValid = _formKey.currentState!.validate();
    });
  }

  void emailClear() {
    _emailCtr.clear();
    emailChanged('');
  }

  void submitAction() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Listener(
          onPointerDown: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
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
                        style: TextStyle(fontSize: 16, color: MyColors.orange400),
                      ),
                    ),

                    SizedBox(height: 50),
                    TextFormField(
                      controller: _emailCtr,
                      validator: (value) => value == null || value.isEmpty ? '' : null,
                      onChanged: (value) => emailChanged(value),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      cursorColor: MyColors.gray800,
                      cursorErrorColor: MyColors.gray800,
                      style: TextStyle(fontSize: 14, color: MyColors.gray800),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.login_email_caption,
                        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: MyColors.gray800),
                        hintText: 'example@email.com',
                        hintStyle: TextStyle(fontSize: 14, color: MyColors.gray500),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.gray300, width: 2)),
                        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.gray300, width: 2)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyColors.violet200, width: 2),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyColors.violet200, width: 2),
                        ),
                        // suffix: Text('data'),
                        suffixIcon: _showEmailClear
                            ? IconButton(
                                onPressed: () => emailClear(),
                                icon: Icon(Icons.cancel),
                                iconSize: 18,
                                color: MyColors.gray600,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: _codeCtr,
                      validator: (value) => value == null || value.isEmpty ? '' : null,
                      onChanged: (value) => codeChanged(value),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      cursorColor: MyColors.gray800,
                      cursorErrorColor: MyColors.gray800,
                      style: TextStyle(fontSize: 14, color: MyColors.gray800),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.login_code_caption,
                        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: MyColors.gray800),
                        hintText: '123456',
                        hintStyle: TextStyle(fontSize: 14, color: MyColors.gray500),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.gray300, width: 2)),
                        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.gray300, width: 2)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyColors.violet200, width: 2),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyColors.violet200, width: 2),
                        ),
                        suffixIcon: TextButton(
                          onPressed: () {},
                          child: Text(AppLocalizations.of(context)!.login_code_send),
                        ),
                      ),
                    ),
                    // Spacer(),
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
      ),
    );
  }
}

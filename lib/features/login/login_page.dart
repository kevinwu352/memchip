import 'package:flutter/material.dart';

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
  void initState() {
    super.initState();
    // _emailCtr.addListener(() {
    //   setState(() {
    //     _showEmailClear = _emailCtr.text.isNotEmpty;
    //     _allValid = _formKey.currentState!.validate();
    //     print('all-valid:$_allValid');
    //   });
    // });
  }

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

  void emailClear() {
    _emailCtr.clear();
    emailChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(width: double.infinity, child: Text('Sign In')),
                  SizedBox(width: double.infinity, child: Text('Hi there! Nice to see you again.')),

                  SizedBox(height: 50),
                  TextFormField(
                    controller: _emailCtr,
                    validator: (value) => value == null || value.isEmpty ? '' : null,
                    onChanged: (value) => emailChanged(value),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    cursorErrorColor: Colors.purple,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.green),
                      hintText: 'example@email.com',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                      errorBorder: UnderlineInputBorder(),
                      focusedErrorBorder: UnderlineInputBorder(),
                      suffixIcon: _showEmailClear
                          ? IconButton(onPressed: () => emailClear(), icon: Icon(Icons.cancel))
                          : null,
                    ),
                  ),

                  Spacer(),
                  IconButton(
                    onPressed: _allValid
                        ? () {
                            print('submit');
                            final val = _formKey.currentState!.validate();
                            print('valid:$val');
                          }
                        : null,
                    icon: Icon(Icons.run_circle),
                  ),
                  // TextButton(onPressed: () {}, child: Text('Sign in')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

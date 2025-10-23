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

  @override
  void initState() {
    super.initState();
    _emailCtr.addListener(() {
      setState(() {
        _showEmailClear = _emailCtr.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _emailCtr.dispose();
    _codeCtr.dispose();
    super.dispose();
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
                    validator: (value) => null,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'example@email.com',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: UnderlineInputBorder(),
                      suffixIcon: _showEmailClear
                          ? IconButton(onPressed: () => _emailCtr.clear(), icon: Icon(Icons.cancel))
                          : null,
                    ),
                  ),

                  Spacer(),
                  TextButton(onPressed: () {}, child: Text('Sign in')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

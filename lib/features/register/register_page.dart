import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/pch.dart';
import 'register_vm.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.network});
  final Networkable network;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final vm = RegisterVm(
    network: widget.network,
    onSnack: (msg) => context.showSnack(msg),
    onRegistered: () => context.pop(),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    vm.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.register_page_title)),
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, child) => SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    spacing: 20,
                    children: [
                      TextField(
                        controller: vm.accountController,
                        onChanged: (value) => setState(() {}),
                        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        enableSuggestions: false,
                        cursorColor: MyColors.gray800,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: AppLocalizations.of(context)!.register_account_title,
                          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: MyColors.gray800),
                          hintText: AppLocalizations.of(context)!.register_account_ph,
                          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray500),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.gray300, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.violet200, width: 2),
                          ),
                          suffixIcon: vm.accountShowClear
                              ? IconButton(
                                  onPressed: vm.accountClear,
                                  icon: Icon(Icons.cancel),
                                  iconSize: 18,
                                  color: MyColors.gray600,
                                  focusNode: FocusNode(skipTraversal: true),
                                )
                              : null,
                        ),
                      ),
                      TextField(
                        controller: vm.codeController,
                        onChanged: (value) => setState(() {}),
                        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        enableSuggestions: false,
                        cursorColor: MyColors.gray800,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        obscureText: !vm.codeShow,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: AppLocalizations.of(context)!.register_code_title,
                          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: MyColors.gray800),
                          hintText: '123456',
                          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray500),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.gray300, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.violet200, width: 2),
                          ),
                          suffixIcon: vm.codeController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () => vm.codeShow = !vm.codeShow,
                                  icon: Image.asset(
                                    vm.codeShow ? 'assets/images/password_on.png' : 'assets/images/password_off.png',
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                )
                              : null,
                        ),
                      ),
                      TextField(
                        controller: vm.confirmController,
                        onChanged: (value) => setState(() {}),
                        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        enableSuggestions: false,
                        cursorColor: MyColors.gray800,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (value) => FocusManager.instance.primaryFocus?.unfocus(),
                        obscureText: !vm.confirmShow,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: AppLocalizations.of(context)!.register_confirm_title,
                          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: MyColors.gray800),
                          hintText: '123456',
                          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray500),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.gray300, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.violet200, width: 2),
                          ),
                          suffixIcon: vm.confirmController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () => vm.confirmShow = !vm.confirmShow,
                                  icon: Image.asset(
                                    vm.confirmShow ? 'assets/images/password_on.png' : 'assets/images/password_off.png',
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: MyColors.violet300),
                        onPressed: vm.submitEnabled ? vm.submitAction : null,
                        child: vm.submiting
                            ? CircularProgressIndicator.adaptive(backgroundColor: MyColors.white100)
                            : Text(
                                AppLocalizations.of(context)!.register_submit_btn,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/l10n/localizations.dart';
import '/core/core.dart';
import '/storage/storage.dart';
import '/network/network.dart';
import '/theme/theme.dart';
import '/utils/event_bus.dart';
import '/utils/router.dart';
import 'login_vm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.network, required this.secures, required this.defaults});
  final Networkable network;
  final Secures secures;
  final Defaults defaults;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final vm = LoginVm(network: widget.network, secures: widget.secures, defaults: widget.defaults);

  @override
  void initState() {
    super.initState();
    _subscribeSnack();
    _subscribeDone();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, child) {
          return SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, kSafeTop, 30, kSafeBot),
              child: Form(
                key: vm.formKey,
                child: Column(
                  children: [
                    Container(padding: EdgeInsets.only(top: 30), child: Image.asset('assets/images/login_logo.png')),

                    Container(
                      padding: EdgeInsets.only(top: 80),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.login_title,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: MyColors.orange400),
                          ),
                          Text(
                            AppLocalizations.of(context)!.login_subtitle,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: MyColors.orange400),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: CupertinoSlidingSegmentedControl(
                        children: Method.values.toMap(
                          (e) => Text(
                            e.name(context),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: vm.method == e ? MyColors.white100 : MyColors.gray500,
                            ),
                          ),
                        ),
                        groupValue: vm.method,
                        onValueChanged: (value) {
                          if (value != null) vm.method = value;
                        },
                        thumbColor: MyColors.violet300,
                        backgroundColor: MyColors.gray300,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        spacing: 20,
                        children: [
                          TextFormField(
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
                              labelText: AppLocalizations.of(context)!.login_account_title,
                              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: MyColors.gray800),
                              hintText: vm.method.accountPh(context),
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
                          TextFormField(
                            controller: vm.codeController,
                            onChanged: (value) => setState(() {}),
                            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            enableSuggestions: false,
                            cursorColor: MyColors.gray800,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (value) => FocusManager.instance.primaryFocus?.unfocus(),
                            obscureText: vm.codeShouldMask,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: vm.method.passcodeTitle(context),
                              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: MyColors.gray800),
                              hintText: '123456',
                              hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray500),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: MyColors.gray300, width: 2),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: MyColors.violet200, width: 2),
                              ),
                              suffixIcon: vm.method == Method.password
                                  ? vm.codeShowClear
                                        ? IconButton(
                                            onPressed: () => vm.codeShow = !vm.codeShow,
                                            icon: Image.asset(
                                              vm.codeShow
                                                  ? 'assets/images/password_on.png'
                                                  : 'assets/images/password_off.png',
                                            ),
                                            focusNode: FocusNode(skipTraversal: true),
                                          )
                                        : null
                                  : UnconstrainedBox(
                                      child: FilledButton(
                                        style: FilledButton.styleFrom(
                                          backgroundColor: MyColors.violet100,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          minimumSize: Size(82, 24),
                                        ),
                                        onPressed: vm.sendEnabled ? vm.sendAction : null,
                                        child: vm.sending
                                            ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white)
                                            : Text(
                                                AppLocalizations.of(context)!.login_code_send_btn(vm.sendSeconds),
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                              ),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FilledButton(
                            style: FilledButton.styleFrom(backgroundColor: MyColors.violet300),
                            onPressed: vm.submitEnabled ? vm.submitAction : null,
                            child: vm.submiting
                                ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white)
                                : Text(
                                    AppLocalizations.of(context)!.login_submit_btn,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                          ),
                          TextButton(
                            onPressed: () => context.push(Routes.register),
                            child: Text(
                              AppLocalizations.of(context)!.login_register_btn,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: MyColors.gray500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _subscribeSnack() {
    vm.snackPub.addListener(() {
      final msg = vm.snackPub.value?.localized(context);
      if (msg != null && msg.isNotEmpty) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
      }
      vm.snackPub.value = null;
    });
  }

  void _subscribeDone() {
    vm.donePub.addListener(() {
      if (vm.donePub.value) {
        context.go(Routes.home);
        final bus = context.read<EventBus>();
        Future.delayed(Duration(milliseconds: 500), () => bus.fire(type: EventType.accountLogin));
      }
    });
  }
}

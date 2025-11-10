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
  late LoginVm vm = LoginVm(network: widget.network, secures: widget.secures, defaults: widget.defaults);

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
                    SizedBox(height: 32),
                    Image.asset('assets/images/login_logo.png'),

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
                      controller: vm.emailController,
                      onChanged: vm.emailChanged,
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
                        labelText: AppLocalizations.of(context)!.login_email_title,
                        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: MyColors.gray800),
                        hintText: 'example@email.com',
                        hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray500),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.gray300, width: 2)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyColors.violet200, width: 2),
                        ),
                        suffixIcon: vm.emailShowClear
                            ? IconButton(
                                onPressed: vm.clearAction,
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
                      controller: vm.codeController,
                      onChanged: vm.codeChanged,
                      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      cursorColor: MyColors.gray800,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) => FocusManager.instance.primaryFocus?.unfocus(),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: AppLocalizations.of(context)!.login_code_title,
                        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: MyColors.gray800),
                        hintText: '123456',
                        hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray500),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.gray300, width: 2)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyColors.violet200, width: 2),
                        ),
                        suffixIcon: UnconstrainedBox(
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              backgroundColor: MyColors.violet100,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: Size(82, 24),
                            ),
                            onPressed: vm.sendEnabled ? vm.sendAction : null,
                            child: vm.sending
                                ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white)
                                : Text(
                                    AppLocalizations.of(context)!.login_code_send_btn(vm.countdown),
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                  ),
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
                        ),
                        onPressed: vm.submitEnabled ? vm.submitAction : null,
                        child: vm.submiting
                            ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white)
                            : Text(
                                AppLocalizations.of(context)!.login_submit_btn,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
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

import 'package:chat/redux/actions/action.dart';
// import 'package:chat/redux/models/quote.dart';

class SignInFBAction extends AppAction{}

class SignOutAction extends AppAction{}

class RegisterWithEPAction extends AppAction{
  final String mail;
  final String pass;
  RegisterWithEPAction({this.mail, this.pass});

  @override String toString() => "RegisterWithEPAction{$mail,$pass}";
}

class SignInWithEPAction extends AppAction{
  final String mail;
  final String pass;
  SignInWithEPAction({this.mail, this.pass});

  @override String toString() => "SignInWithEPAction{$mail,$pass}";
}

class SendMsgAction extends AppAction{

  final String msg;
  SendMsgAction(this.msg);

  @override String toString() => "SendMsgAction{$msg}";
}

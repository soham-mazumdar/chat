import 'dart:developer';

import 'package:chat/redux/actions/allActions.dart';
import 'package:chat/redux/actions/action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:chat/redux/models/app_state.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPass = false;
  bool isNewUser = true;
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(
      converter: (store) {
        final Map<String, dynamic> args = {
          "isLoading": store.state.isLoading,
          "SignInFB": () {
            store.dispatch(IsLoadingAction(true));
            return store.dispatch(SignInFBAction());
          },
          "registerWithEP": (_mail, _pass) {
            // store.dispatch(IsLoadingAction(true));
            return store.dispatch(RegisterWithEPAction(mail: _mail, pass: _pass));
          },
          "SignInWithEP": (_mail, _pass) {
            // store.dispatch(IsLoadingAction(true));
            return store.dispatch(SignInWithEPAction(mail: _mail, pass: _pass));
          },
          
        };
        return args;
      },
      builder: (context, args) {
        final Function signInFB = args["SignInFB"];
        final Function registerWithEP = args["registerWithEP"];
        final Function signInWithEP = args["SignInWithEP"];
        
        final bool isLoading = args["isLoading"];
        log(isLoading.toString());
        
        final _formKey = GlobalKey<FormState>();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
              child: isLoading 
              ? Container(
                child: Center(child: CircularProgressIndicator(),)
              )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: Center(
                      child:
                          Image.asset('assets/images/logo.png', width: 100))),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _mailController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(color: Colors.black),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0)),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.white)),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (value) {
                              if (value.isEmpty) {
                                return 'Required';
                              }
                              if(RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)){
                                return 'Enter a valid email';
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passController,
                          style: TextStyle(color: Colors.white),
                          obscureText: !showPass,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(color: Colors.black),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0)),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.white)),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                              icon: Icon(
                                !showPass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password is required';
                            }
                            if(value.length < 8){
                              return 'Password needs to be min 8 character';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: (){
                            
                              if (_formKey.currentState.validate()) {
                                  if(isNewUser)
                                    registerWithEP(_mailController.text, _passController.text);
                                  else
                                    signInWithEP(_mailController.text, _passController.text);
                              }
                            
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Text(isNewUser ?'Register' :'Login',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ))),
                        ),
                        FlatButton(
                          onPressed: (){
                            setState(() {
                              isNewUser = !isNewUser;
                            });
                          }, 
                          child: Text('Already an User?',style: TextStyle(color: Colors.white),)
                        ),
                        Divider(
                          color: Colors.white,
                          height: 60,
                        ),
                        GestureDetector(
                          onTap: (){
                            signInFB();
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(88, 144, 255, 1),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Wrap(
                                children: [
                                  Image.asset(
                                    'assets/images/fb.png',
                                    width: 18,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Login With Facebook',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))
                                ],
                              )),
                        ),
                      ],
                    )),
              )
            ],
          )),
        );
        // return Scaffold(
        //   body: isLoading ? Container(
        //     height: _height,
        //     width: MediaQuery.of(context).size.width,
        //     color: Colors.teal,
        //     child: Stack(
        //       children: [
        //         Positioned(
        //           top: 0,
        //           height: _height * 0.2,
        //           width: _width,
        //           child: Container(height: _height * 0.2,color: AppColors.one)
        //         ),
        //         Positioned(
        //           top: _height * 0.2,
        //           height: _height * 0.2,
        //           width: _width,
        //           child: Container(height: _height * 0.2,color: AppColors.two)
        //         ),
        //         Positioned(
        //           top: _height * 0.4,
        //           height: _height * 0.2,
        //           width: _width,
        //           child: Container(height: _height * 0.2,color: AppColors.three)
        //         ),
        //         Positioned(
        //           top: _height * 0.6,
        //           height: _height * 0.2,
        //           width: _width,
        //           child: Container(height: _height * 0.2,color: AppColors.four)
        //         ),
        //         Positioned(
        //           top: _height * 0.8,
        //           height: _height * 0.2,
        //           width: _width,
        //           child: Container(height: _height * 0.2,color: AppColors.five)
        //         ),
        //         Positioned(
        //           height: _height,
        //           width: _width,
        //           child: Container(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: [
        //                 Image.asset('assets/images/logo.png',width: 150,),
        //                 SizedBox(height: 70),
        //                 CircularProgressIndicator(),
        //                 SizedBox(height: 70),
        //                 Text('Fetching some incredible quotes for you')
        //               ],
        //             ),
        //           ),
        //         ),
        //         Positioned(
        //           bottom: 0,
        //           child: Container(
        //             height: 40,
        //             width: _width,
        //             color: AppColors.five,
        //             alignment: Alignment.center,
        //             child: Text('Powered by favqs.com'),
        //           )
        //         )
        //       ],
        //     )
        //   ) : Container(
        //     height: _height,
        //     width: MediaQuery.of(context).size.width,
        //     color: Colors.teal,
        //     child: Stack(
        //       children: [
        //         Positioned(
        //           top: 0,
        //           height: _height * 0.2,
        //           width: _width,
        //           child: Container(height: _height * 0.2,color: AppColors.one)
        //         ),
        //         Positioned(
        //           top: _height * 0.2,
        //           height: _height * 0.2,
        //           width: _width,
        //           child: Container(height: _height * 0.2,color: AppColors.two)
        //         ),
        //         Positioned(
        //           top: _height * 0.4,
        //           height: _height * 0.2,
        //           width: _width,
        //           child: Container(height: _height * 0.2,color: AppColors.three)
        //         ),
        //         Positioned(
        //           top: _height * 0.6,
        //           height: _height * 0.2,
        //           width: _width,
        //           child: Container(height: _height * 0.2,color: AppColors.four)
        //         ),
        //         Positioned(
        //           top: _height * 0.8,
        //           height: _height * 0.2,
        //           width: _width,
        //           child: Container(height: _height * 0.2,color: AppColors.five)
        //         ),
        //         Positioned(
        //           top: 50,
        //           right: 20,
        //           child: GestureDetector(
        //             onTap: () {
        //               navigate('/saved');
        //             },
        //             child: Icon(
        //               Icons.bookmark,
        //               size: 26.0,
        //               color: Colors.white,
        //             ),
        //           )
        //         ),
        //         Positioned(
        //           height: _height,
        //           width: _width,
        //           child: Container(
        //             width: MediaQuery.of(context).size.width,
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: [
        //                 SizedBox(height:50),
        //                 Image.asset('assets/images/logo.png',width: 150,),
        //                 SizedBox(height:40),
        //                 SizedBox(height:40),
        //                 Container(
        //                   height: MediaQuery.of(context).size.height * 0.5,
        //                   child: TinderSwapCard(
        //                     swipeUp: true,
        //                     swipeDown: true,
        //                     orientation: AmassOrientation.BOTTOM,
        //                     totalNum: quotes.length,
        //                     stackNum: 3,
        //                     swipeEdge: 1.0,
        //                     maxWidth: MediaQuery.of(context).size.width,// * 0.9,
        //                     maxHeight: MediaQuery.of(context).size.height,// * 0.9,
        //                     minWidth: MediaQuery.of(context).size.width * 0.8,
        //                     minHeight: MediaQuery.of(context).size.width * 0.8,
        //                     cardBuilder: (context, index){
        //                       return Container(
        //                           decoration: BoxDecoration(
        //                             borderRadius: BorderRadius.circular(10),
        //                             color: Colors.white,
        //                             border: Border.all(
        //                               width: 3,
        //                               color: AppColors.four,
        //                             )
        //                           ),
        //                           width: MediaQuery.of(context).size.width,
        //                           alignment: Alignment.centerLeft,
        //                           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        //                           child: Stack(
        //                             fit: StackFit.expand,
        //                             children: [
        //                               Positioned(
        //                                 top: 0,
        //                                 left: 0,
        //                                 right: 0,
        //                                 child: Icon(Icons.format_quote,color: AppColors.four,size: 90,),
        //                               ),
        //                               Container(
        //                                 child: ListView(
        //                                   children: [
        //                                     Text(
        //                                       quotes[index].body,
        //                                       style: TextStyle(
        //                                         fontSize: 28,
        //                                         fontWeight: FontWeight.w300
        //                                       ),
        //                                     ),
        //                                     SizedBox(height: 20,),
        //                                     Container(
        //                                       alignment: Alignment.topLeft,
        //                                       child: Text(
        //                                         '-' + quotes[index].author,
        //                                         style: TextStyle(
        //                                           fontSize: 20,
        //                                           fontWeight: FontWeight.w500
        //                                         ),
        //                                       ),
        //                                     )
        //                                   ],
        //                                 ),
        //                               ),
        //                               Positioned(
        //                                 bottom: 0,
        //                                 right: 0,
        //                                 child: GestureDetector(
        //                                   onTap: (){
        //                                     Scaffold.of(context).showSnackBar(
        //                                       SnackBar(
        //                                         behavior: SnackBarBehavior.floating,
        //                                         content: Text('saved')
        //                                       )
        //                                     );
        //                                     saveQuote(quotes[index]);
        //                                   },
        //                                   child: Icon(Icons.bookmark_border_rounded,color: AppColors.four,),
        //                                 ),
        //                               )
        //                             ],
        //                           ),
        //                         );
        //                     },
        //                     cardController: controller = CardController(),
        //                     // swipeUpdateCallback:
        //                     //     (DragUpdateDetails details, Alignment align) {
        //                     //   /// Get swiping card's alignment
        //                     //   if (align.x < 0) {
        //                     //     //Card is LEFT swiping
        //                     //   } else if (align.x > 0) {
        //                     //     //Card is RIGHT swiping
        //                     //   }
        //                     // },

        //                     swipeCompleteCallback:
        //                       (CardSwipeOrientation orientation, int index) {
        //                         // print(index);
        //                         // if(index == 2)
        //                           getQuotes();
        //                         /// Get orientation & index of swiped card!
        //                       },
        //                   ),
        //                 ),

        //               ],
        //             ),
        //           ),
        //         ),
        //         Positioned(
        //           bottom: 0,
        //           child: Container(
        //             height: 40,
        //             width: _width,
        //             color: AppColors.five,
        //             alignment: Alignment.center,
        //             child: Text('Powered by favqs.com'),
        //           )
        //         )
        //       ],
        //     )
        //   )
        // );
      },
    );
  }
}

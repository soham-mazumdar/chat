import 'package:chat/redux/actions/allActions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:chat/redux/models/app_state.dart';

class ChatPage extends StatelessWidget {
  final TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(
      converter: (store) {
        final Map<String, dynamic> args = {
          "isLoading": store.state.isLoading,
          "send": (msg) {
            print(msg);
            return store.dispatch(SendMsgAction(msg));
          },
          "signOut": (){
            store.dispatch(SignOutAction());
          }
        };
        return args;
      },
      builder: (context, args) {
        final Function send = args["send"];
        final Function signOut = args["signOut"];
        final bool isLoading = args["isLoading"];

        

        return Scaffold(
            appBar: AppBar(
              title: Text('Chatty'),
              leading: IconButton(
                icon: Icon(Icons.logout),
                onPressed: (){
                  signOut();
                },
                
              ),
            ),
            body: isLoading
            ? Container(
                child: Center(child: CircularProgressIndicator(),)
              )
            : Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("chats")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Text('Loading...');
                        default:
                          var reversedList =
                              snapshot.data.documents.reversed.toList();
                          return new ListView.builder(
                              reverse: true,
                              padding: EdgeInsets.all(0),
                              // reverse: true,
                              // shrinkWrap: true,
                              itemCount: reversedList.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot ds = reversedList[index];
                                bool sentByMe =
                                    FirebaseAuth.instance.currentUser?.uid ==
                                        ds["uid"];
                                return Container(
                                  padding: EdgeInsets.only(
                                      top: 8,
                                      bottom: 8,
                                      left: sentByMe ? 0 : 24,
                                      right: sentByMe ? 24 : 0),
                                  alignment: sentByMe
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    margin: sentByMe
                                        ? EdgeInsets.only(left: 30)
                                        : EdgeInsets.only(right: 30),
                                    padding: EdgeInsets.only(
                                        top: 7,
                                        bottom: 17,
                                        left: 20,
                                        right: 20),
                                    decoration: BoxDecoration(
                                        color: sentByMe ? Color.fromRGBO(0,126,244, 1) : Color(0x1AFFFFFF),
                                        borderRadius: sentByMe
                                            ? BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                                bottomLeft: Radius.circular(12))
                                            : BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(23)),
                                      ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(ds['name'],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'OverpassRegular',
                                            fontWeight: FontWeight.w700,
                                          )
                                        ),
                                        SizedBox(height: 7,),
                                        Text(ds['msg'],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'OverpassRegular',
                                            fontWeight: FontWeight.w300
                                          )
                                        ),
                                        SizedBox(height: 15,),
                                        Text(ds['time'],

                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              // backgroundColor: Colors.white,
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontFamily: 'OverpassRegular',
                                              fontWeight: FontWeight.w300
                                            )
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _chatController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            
                            filled: true,
                            fillColor: Color(0x1AFFFFFF),
                            hintText: 'Type your Msg',
                            hintStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(color: Colors.black),
                            contentPadding: EdgeInsets.fromLTRB(30,20,30,50),
                            suffixIcon: IconButton(
                              padding: EdgeInsets.fromLTRB(30,20,30,50),
                              onPressed: () {
                                if (_chatController.text != '')
                                  send(_chatController.text);
                                  _chatController.text = '';
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}

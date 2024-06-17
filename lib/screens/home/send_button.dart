import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/services/database.dart';
import 'package:provider/provider.dart';

class SendButton extends StatefulWidget {
  final String? friuid;
  final int? numberofchats;
  final controller;
  SendButton({this.friuid , this.numberofchats, this.controller});

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  String message = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController textarea = TextEditingController();

  void scrollDown() {
    final double end = widget.controller.position.maxScrollExtent;
    widget.controller.jumpTo(end+40);
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Container(
      height: 60,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width/1.2,
                  height: 40,
                  child: TextFormField(
                    controller: textarea,
                    validator: (val) => val!.isEmpty ? 'Enter Message': null,
                    onChanged: (val) {
                      setState(() {
                        message = val;
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()){
                      textarea.clear();
                      await DatabaseBackend().sendmessage(
                          message: message,
                          frienduid: widget.friuid,
                          uid: _user?.uid,
                          numberofchats: widget.numberofchats);
                      // scrollDown();
                      await DatabaseBackend().receivemessage(
                          message: message,
                          frienduid: widget.friuid,
                          uid: _user?.uid,
                          numberofchats: widget.numberofchats);
                   }
                  },
                  icon: Icon(Icons.send , size: 30,color: Colors.blue,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


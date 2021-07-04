import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_test/user.dart';

typedef OnDelete();

class UserCard extends StatefulWidget {
  final User user;
  final state = _UserCardState();
  final OnDelete onDelete;

  UserCard({Key key, this.user, this.onDelete}) : super(key: key);
  @override
  _UserCardState createState() => state;

  bool isValid() => state.validate();
}

class _UserCardState extends State<UserCard> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                // leading: Icon(Icons.question_answer_rounded),
                elevation: 0,
                title: TextFormField(
                  initialValue: widget.user.fullName,
                  // onSaved: (val) => widget.user.fullName = val,
                  // validator: (val) =>
                  //     val.length < 3 ? null : 'insira um valor maior',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Tipo Questao',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintText: 'insira a Questao',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    isDense: true,
                  ),
                ),
                backgroundColor: Color(0xFF2e2a4f),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.trash,
                    ),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  initialValue: widget.user.fullName,
                  onSaved: (val) => widget.user.fullName = val,
                  validator: (val) =>
                      val.length < 3 ? null : 'insira um valor maior',
                  decoration: InputDecoration(
                    labelText: 'resposta',
                    hintText: 'insira a resposta',
                    icon: Icon(Icons.circle),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  initialValue: widget.user.fullName,
                  onSaved: (val) => widget.user.fullName = val,
                  validator: (val) =>
                      val.length < 3 ? null : 'insira um valor maior',
                  decoration: InputDecoration(
                    labelText: 'resposta',
                    hintText: 'insira a resposta',
                    icon: Icon(Icons.circle),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}

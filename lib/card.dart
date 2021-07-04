import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_test/card_model.dart';

import 'form.dart';
import 'form_model.dart';

typedef OnDelete();

class CardWidget extends StatefulWidget {
  final CardModel cards;
  final state = _CardWidgetState();
  final OnDelete onDelete;

  CardWidget({Key key, this.cards, this.onDelete}) : super(key: key);
  @override
  _CardWidgetState createState() => state;

  bool isValid() => state.validate();
}

class _CardWidgetState extends State<CardWidget> {
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  final card = GlobalKey<FormState>();
  List<FormWidget> forms = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: card,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                // leading: Icon(Icons.question_answer_rounded),
                elevation: 0,
                title: TextFormField(
                  initialValue: widget.cards.fullName,
                  // onSaved: (val) => widget.user.fullName = val,
                  // validator: (val) =>
                  //     val.length < 3 ? null : 'insira um valor maior',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Insira a Questao',
                    labelStyle: TextStyle(
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
              Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2e2a4f),
                        Color(0xFFC42224),
                      ],
                      end: Alignment.topRight,
                      begin: Alignment.bottomLeft,
                    ),
                  ),
                  child: forms.length <= 0
                      ? Center(
                          child: TextButton(
                            onPressed: onAddForm,
                            child: Text('insira a resposta'),
                          ),
                        )
                      : Column(
                          children: [
                            Card(
                              child: ListTile(
                                leading: Icon(Icons.radio_button_unchecked),
                                title: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    // prefixIcon: Icon(Icons.search),
                                    suffixIcon: _controller.text.length > 0
                                        ? GestureDetector(
                                            onTap: _controller
                                                .clear, // removes the content in the field
                                            child: Icon(Icons.clear_rounded),
                                          )
                                        : null,
                                  ),
                                ),
                                onTap: () {
                                  // changes the value inside the field
                                  _controller.text = 'insira a resposta';
                                },
                              ),
                            ),
                            Card(
                              child: ListTile(
                                leading: Icon(Icons.radio_button_unchecked),
                                title: TextField(
                                  controller: _controller2,
                                  decoration: InputDecoration(
                                    // prefixIcon: Icon(Icons.search),
                                    suffixIcon: _controller2.text.length > 0
                                        ? GestureDetector(
                                            onTap: _controller2
                                                .clear, // removes the content in the field
                                            child: Icon(Icons.clear_rounded),
                                          )
                                        : null,
                                  ),
                                ),
                                onTap: () {
                                  // changes the value inside the field
                                  _controller2.text = 'insira a resposta';
                                },
                              ),
                            ),
                          ],
                        ))
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = card.currentState.validate();
    if (valid) card.currentState.save();
    return valid;
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _form = FormModel();
      forms.add(FormWidget(
        forms: _form,
        onDelete: () => onDelete(_form),
      ));
    });
  }

  ///on form user deleted
  void onDelete(FormModel _user) {
    setState(() {
      var find = forms.firstWhere(
        (it) => it.forms == _user,
        orElse: () => null,
      );
      if (find != null) forms.removeAt(forms.indexOf(find));
    });
  }
}

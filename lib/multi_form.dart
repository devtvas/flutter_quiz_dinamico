import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_test/pages/home.dart';
import 'package:quiz_test/card_model.dart';

import 'empty_card_state.dart';

import 'card.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<CardWidget> cards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color(0xFFC42224),
          elevation: .0,
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.wb_cloudy,
          //   ),
          //   onPressed: onCloud,
          // ),
          title: Text(
            'CADASTRAR QUESTOES',
            style: TextStyle(fontSize: 16),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     child: Icon(
          //       Icons.save,
          //       color: Colors.white,
          //       size: 26,
          //     ),
          //     onPressed: onSave,
          //   )
          // ],
        ),
        body: Container(
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
          child: cards.length <= 0
              ? Center(
                  child: EmptyCardState(
                    title: 'Quiz',
                    message: 'Adicione tocando no botão abaixo',
                    onPressed: onAddForm,
                  ),
                )
              : ListView.builder(
                  addAutomaticKeepAlives: true,
                  itemCount: cards.length,
                  itemBuilder: (_, i) => cards[i],
                ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: Icon(
                CupertinoIcons.bookmark_solid,
                color: Colors.white,
                size: 26,
              ),
              onPressed: onSave,
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFFC42224),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              child: Icon(
                CupertinoIcons.add,
                size: 26,
              ),
              onPressed: onAddForm,
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFFC42224),
            ),
          ],
        ));
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = CardModel();
      cards.add(CardWidget(
        cards: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  ///on form user deleted
  void onDelete(CardModel _user) {
    setState(() {
      var find = cards.firstWhere(
        (it) => it.cards == _user,
        orElse: () => null,
      );
      if (find != null) cards.removeAt(cards.indexOf(find));
    });
  }

  ///on save forms
  void onSave() {
    if (cards.length > 0) {
      var allValid = true;
      cards.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = cards.map((it) => it.cards).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
              backgroundColor: Color(0xFFC42224),
              appBar: AppBar(
                backgroundColor: Color(0xFFC42224),
                title: Text('Lista de Questoes'),
              ),
              body: Container(
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
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, i) => ListTile(
                    leading: CircleAvatar(
                      child: Text(data[i].fullName.substring(0, 1)),
                    ),
                    title: Text(data[i].fullName),
                    subtitle: Text(data[i].email),
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage())),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }
  }

  ///on save forms
  void onCloud() {
    if (cards.length > 0) {
      var allValid = true;
      cards.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = cards.map((it) => it.cards).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('List of cards'),
              ),
              body: ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, i) => ListTile(
                  leading: CircleAvatar(
                    child: Text(data[i].fullName.substring(0, 1)),
                  ),
                  title: Text(data[i].fullName),
                  subtitle: Text(data[i].email),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}

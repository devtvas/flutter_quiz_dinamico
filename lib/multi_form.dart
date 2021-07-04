import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_test/pages/home.dart';
import 'package:quiz_test/user.dart';

import 'empty_card_state.dart';

import 'form.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<UserCard> users = [];

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
          child: users.length <= 0
              ? Center(
                  child: EmptyCardState(
                    title: 'Oops',
                    message: 'Adicione o formulário tocando no botão abaixo',
                    onPressed: onAddForm,
                  ),
                )
              : ListView.builder(
                  addAutomaticKeepAlives: true,
                  itemCount: users.length,
                  itemBuilder: (_, i) => users[i],
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

  ///on form user deleted
  void onDelete(User _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = User();
      users.add(UserCard(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  ///on save forms
  void onSave() {
    if (users.length > 0) {
      var allValid = true;
      users.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = users.map((it) => it.user).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('Lista de Questoes'),
              ),
              body: ListView.builder(
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
        );
      }
    }
  }

  ///on save forms
  void onCloud() {
    if (users.length > 0) {
      var allValid = true;
      users.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = users.map((it) => it.user).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('List of Users'),
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

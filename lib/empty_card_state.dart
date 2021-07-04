import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyCardState extends StatelessWidget {
  final String title, message;
  VoidCallback onPressed;
  EmptyCardState({this.title, this.message, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 16,
      color: Theme.of(context).cardColor.withOpacity(.95),
      shadowColor: Theme.of(context).accentColor.withOpacity(.5),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.headline),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(message),
            ),
            IconButton(
                icon: Icon(
                  CupertinoIcons.add,
                  size: 50,
                ),
                onPressed: onPressed)
          ],
        ),
      ),
    );
  }
}

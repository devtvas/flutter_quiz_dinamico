import 'package:flutter/material.dart';
import 'dart:math';

class CorrectWrongOverlay extends StatefulWidget {
  final bool _isCurrect;
  final VoidCallback _onTap;

  CorrectWrongOverlay(this._isCurrect, this._onTap);

  @override
  State<StatefulWidget> createState() => new CorrectWrongOverlaySate();
}

class CorrectWrongOverlaySate extends State<CorrectWrongOverlay>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        duration: new Duration(seconds: 2), vsync: this);

    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.elasticOut);

    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();

    _iconAnimationController.dispose();
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double PI;
    return new Material(
      color: Colors.black54,
      child: new InkWell(
        onTap: () => widget._onTap(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: new Transform.rotate(
                angle: _iconAnimation.value * 2 * PI,
                child: new Icon(
                  widget._isCurrect ? Icons.done : Icons.clear,
                  size: _iconAnimation.value * 55.0,
                ),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(bottom: 12.0),
            ),
            new Text(
              widget._isCurrect ? "Correct!" : "Wrong",
              style: new TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

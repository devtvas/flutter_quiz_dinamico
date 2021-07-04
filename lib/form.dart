import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'form_model.dart';

typedef OnDelete();

class FormWidget extends StatefulWidget {
  final FormModel forms;
  final state = _FormWidgetState();
  final OnDelete onDelete;

  FormWidget({Key key, this.forms, this.onDelete}) : super(key: key);
  @override
  _FormWidgetState createState() => state;

  bool isValid() => state.validate();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final credentials = FormModel();
  List<FormWidget> form = [];

  @override
  void initState() {
    // whenever the value of the field changes, _updateValue is called
    _controller.addListener(_updateValue);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _updateValue() {
    setState(() {}); // this causes the widget to be built again
  }

  Widget _renderCard(String element) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.radio_button_unchecked),
        title: Text(element),
        onTap: () {
          // changes the value inside the field
          _controller.text = element;
        },
      ),
    );
  }

  Widget _renderTextField() {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        suffixIcon: _controller.text.length > 0
            ? GestureDetector(
                onTap: _controller.clear, // removes the content in the field
                child: Icon(Icons.clear_rounded),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _renderTextField(),
          SizedBox(height: 20),
          // Expanded(
          //   child: ListView(
          //     children: form
          //         .where((element) => element.contains(_controller.text))
          //         .map(_renderCard)
          //         .toList(),
          //   ),
          // )
        ],
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = _formKey.currentState.validate();
    if (valid) _formKey.currentState.save();
    return valid;
  }
}

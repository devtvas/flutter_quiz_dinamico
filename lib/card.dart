import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_test/card_model.dart';

import 'form.dart';
import 'form_model.dart';

typedef OnDelete();

class CardWidget extends StatefulWidget {
  final CardModel? cards;
  final state = _CardWidgetState();
  final OnDelete? onDelete;

  CardWidget({Key? key, this.cards, this.onDelete}) : super(key: key);
  @override
  _CardWidgetState createState() => state;

  bool isValid() => state.validate();
}

class _CardWidgetState extends State<CardWidget> {
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  late TextEditingController _controllerQuestoes, _controllerRespostas;
  final card = GlobalKey<FormState>();
  List<FormWidget> forms = [];
  List<String> campo = [];
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _controllerQuestoes = TextEditingController();
    _controllerRespostas = TextEditingController();
  }

  Widget _respTile(String name) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
          top: BorderSide(color: Colors.grey.shade300),
          left: BorderSide(color: Colors.grey.shade300),
          right: BorderSide(color: Colors.grey.shade300),
        )),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.crop_din),
                onPressed: () {},
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(38),
                  child: Text(
                    name,
                    textScaleFactor: 1,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => setState(() => campo.remove(name)),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                  initialValue: widget.cards!.fullName,
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
                            if (campo == null || campo.isEmpty)
                              const SizedBox(height: 0)
                            else
                              SizedBox(
                                height: 290,
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    children: List<Widget>.generate(
                                        campo.length, (int index) {
                                      return _respTile(campo[index]);
                                    }),
                                  ),
                                ),
                              ),
                            const Divider(),
                            Card(
                              child: ListTile(
                                tileColor: Colors.red[50],
                                leading: const Icon(Icons.queue_sharp),
                                title: TextField(
                                  controller: _controllerRespostas,
                                  decoration: const InputDecoration(
                                      labelText: 'Add Answer´s'),
                                  keyboardType: TextInputType.number,
                                  onChanged: (String value) => setState(() {}),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: _controllerRespostas.text.isEmpty
                                      ? null
                                      : () => setState(() {
                                            campo.add(_controllerRespostas.text
                                                .toString());
                                            _controllerRespostas.clear();
                                          }),
                                ),
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
    var valid = card.currentState!.validate();
    if (valid) card.currentState!.save();
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
        orElse: () => null!,
      );
      if (find != null) forms.removeAt(forms.indexOf(find));
    });
  }
}

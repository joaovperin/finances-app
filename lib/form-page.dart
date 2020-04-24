import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/utils/validators.dart';
import 'package:intl/intl.dart';

import 'model/paper.model.dart';
import 'utils/date-text-input-formatter.dart';
import 'utils/ui-utils.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _paperInputController = TextEditingController();
  final _dateInputController = TextEditingController();
  final _quantityInputController = TextEditingController();
  final _valueInputController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _dateInputController.text = new DateFormat.yMMMd().format(selectedDate);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              _createDateFormField('Date', selectedDate, controller: _dateInputController, datePickerFn: _selectDate),
              _createFormField('Paper name', controller: _paperInputController),
              _createNumberFormField('Quantity', controller: _quantityInputController),
              _createNumberFormField('Value', controller: _valueInputController),
              RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await _scaffoldKey.currentState
                        .showSnackBar(SnackBar(
                          content: Text('Funcionou'),
                          duration: Duration(seconds: 2),
                        ))
                        .closed;
                    popPage(context, data: _createPaper());
                  } else {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Deu pau')));
                  }
                },
                child: Text('Submit'),
              )
            ]),
          ),
        ),
      ),
    );
  }

  TextFormField _createFormField(String hint, {controller, validator = notEmpty, keyboardType, inputFormatters, enabled: true}) {
    return TextFormField(
        controller: controller,
        enabled: enabled,
        maxLengthEnforced: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          labelText: hint,
        ),
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters);
  }

  TextFormField _createNumberFormField(String hint, {controller, validator = notEmpty}) {
    return _createFormField(hint,
        controller: controller,
        validator: validator,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]);
  }

  Widget _createDateFormField(String hint, DateTime initialDate, {TextEditingController controller, Function datePickerFn}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: _createFormField('Date', controller: controller, enabled: false, inputFormatters: [DateTextInputFormatter()]),
        ),
        SizedBox(width: 20.0),
        RaisedButton(
          onPressed: () => datePickerFn(context),
          child: Text(hint),
        ),
      ],
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2019, 1), lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      setState(() => _dateInputController.text = new DateFormat.yMMMd().format(selectedDate));
    }
  }

  Paper _createPaper() {
    return Paper()
      ..date = selectedDate
      ..name = _paperInputController.text.toString()
      ..value = double.parse(_valueInputController.text.toString())
      ..quantity = int.parse(_quantityInputController.text.toString());
  }
}

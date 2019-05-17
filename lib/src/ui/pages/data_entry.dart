import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../../models/item_model.dart';
import '../components/common/page_template.dart';
import '../components/common/styled_button.dart';
import '../components/pickers/money_picker.dart';


import '../helpers/money_controller.dart' show createMoneyController;

class DataEntry extends StatefulWidget {

const  DataEntry(this.item, this.handleSave, {this.onSuccess});

  final ItemModel item;
  final Function handleSave;
  final Function onSuccess;


  @override
  State<StatefulWidget> createState() {
    return _DataEntryState();
  }
}

class _DataEntryState extends State<DataEntry> {
  bool loading = false;
  MoneyMaskedTextController _moneyController;

  @override
  void initState() {
    switch (widget.item.typeValue) {
      case 'money':
        _moneyController = createMoneyController(widget.item.value);
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('---> BUILD: ');
    return PageTemplate(
      title: widget.item.key,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: buildDataEntryWidget(),
            ),
          ),
          StyledButton(
            text: 'save',
            onPressed: _handleSubmit(context),
            loading: loading,
          ),
        ],
      ),
      padding: true,
    );
  }

  // ignore: always_declare_return_types
  buildDataEntryWidget() {
    print('---> buildDataEntry: ${widget.item.typeValue}');
    switch (widget.item.typeValue) {
      case 'money':
        return MoneyPicker(_moneyController);

      default:
        return null;
    }
  }

  // ignore: always_declare_return_types
  _handleSubmit(BuildContext context) => () async {
        setState(() => loading = true);
        dynamic value;
        switch (widget.item.typeValue) {
          case 'money':
            value = _moneyController.numberValue * 100;
            break;
        }

        try {
          await widget.handleSave(widget.item.id, value);
          Navigator.of(context).pop();
        } catch (error) {
          setState(() => loading = false);
        }
      };
}

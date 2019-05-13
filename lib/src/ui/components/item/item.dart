import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../models/item_model.dart';
import '../../pages/data_entry.dart';
import './item_layout.dart';
import '../pickers/date_picker/date_picker_modal.dart' show openDatePicker;
import 'package:provider_mobile/src/ui/components/pickers/photo_uploader.dart'
    show openPhotoUploader;
import '../common/circular_progress.dart';

import '../../../utils/type_check.dart' show isNotNull;
import '../../helpers/money_controller.dart' show formatCost;

class Item extends StatefulWidget {
  final ItemModel item;
  final String id;
  final Function handleSave;
  final String path;
  final Function makeTransition;

  Item(ItemModel item, this.path, this.handleSave, this.makeTransition)
      : this.item = item,
        this.id = item.id;

  @override
  State<StatefulWidget> createState() {
    return _ItemState();
  }
}

class _ItemState extends State<Item> {
  final formatter = DateFormat('dd.MM.yyyy');

  bool loading = false;

  bool get isTapable => (widget.item.isTransition || widget.item.isInput);

  onChanged(dynamic value, {dynamic body}) async {
    setState(() => loading = true);
    await widget.handleSave(widget.item.id, value, body: body);
    setState(() => loading = false);
  }

  onTap(context) => () {
        ItemModel item = widget.item;
        if (item.isTransition) {
          widget.makeTransition(context, item.id);
        } else {
          switch (item.typeValue) {
            case 'date':
              openDatePicker(
                context,
                minimumDate: item.min,
                initialDateTime: item.value,
                maximumDate: item.max,
                onOk: onChanged,
              );
              break;
            case 'money':
              openDataEntry(context);
              break;
            case 'photo':
              openPhotoUploader(context, onLoad: (File photo) {
                onChanged(item.value, body: photo);
              });
              break;
            case 'switch':
              onChanged(!item.value);
              break;
            default:
              return;
          }
        }
      };

  openDataEntry(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DataEntry(
              widget.item,
              widget.handleSave,
              onSuccess: () {
                widget.makeTransition(context);
              },
            ),
      ),
    );
  }

  buildSuffix(BuildContext context) {
    if (loading) {
      return CircularProgress(size: 'small');
    }

    ItemModel item = widget.item;
    switch (item.typeValue) {
      case 'date':
        return isNotNull(item.value)
            ? formatter.format(DateTime.fromMillisecondsSinceEpoch(item.value))
            : null;
      case 'switch':
        return renderSwitch(context);
      case 'money':
        return formatCost(item.value);
      default:
        return item.value?.toString();
    }
  }

  renderSwitch(BuildContext context) {
    ItemModel item = widget.item;
    return Switch(
      activeColor: Theme.of(context).primaryColor,
      value: item.value,
      onChanged: item.isInput ? onChanged : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    ItemModel item = widget.item;
    return ItemLayout(
      picture: item.picture,
      body: item.key,
      suffix: buildSuffix(context),
      link: item.isTransition,
      disabled: !item.isInput,
      onTap: isTapable ? onTap(context) : null,
    );
  }
}

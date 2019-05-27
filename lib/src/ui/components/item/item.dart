import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:user_mobile/src/ui/components/pickers/photo_uploader.dart'
    show openPhotoUploader;

import '../../../models/screen/components/item_model.dart';
import '../../../utils/type_check.dart' show isNotNull;
import '../../helpers/money_controller.dart' show formatCost;
import '../../pages/data_entry.dart';
import '../common/circular_progress.dart';
import '../pickers/date_picker/date_picker_modal.dart' show openDatePicker;
import './item_layout.dart';

class Item extends StatefulWidget {
  Item(ItemModel item, this.path, this.handleSave, this.makeTransition)
      // ignore: prefer_initializing_formals
      : item = item,
        id = item.id;
  final ItemModel item;
  final String id;
  final Function handleSave;
  final String path;
  final Function makeTransition;



  @override
  State<StatefulWidget> createState() {
    return _ItemState();
  }
}

class _ItemState extends State<Item> {
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  bool loading = false;

  // ignore: unnecessary_parenthesis
  bool get isTapable => (widget.item.isTransition || widget.item.isInput);

  // ignore: avoid_void_async
  void onChanged(dynamic value, {dynamic body}) async {
    setState(() => loading = true);
    await widget.handleSave(widget.item.id, value, body: body);
    setState(() => loading = false);
  }

 // ignore: always_declare_return_types
 onTap(BuildContext context) => () {
        final ItemModel item = widget.item;
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
              openPhotoUploader(context, onLoad: (Future<File> cb) async {
                final File photo = await cb;
                if (photo != null) {
                  onChanged(item.value, body: photo);
                }
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

 void  openDataEntry(BuildContext context) {
    Navigator.of(context).push(

      MaterialPageRoute<Widget>(
        builder: (BuildContext context) => DataEntry(
              widget.item,
              widget.handleSave,
              onSuccess: () {
                widget.makeTransition(context);
              },
            ),
      ),
    );
  }


 Object buildSuffix(BuildContext context) {
    if (loading) {
      return const CircularProgress(size: 'small');
    }

    final ItemModel item = widget.item;
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

  Switch renderSwitch(BuildContext context) {
    final ItemModel item = widget.item;
    return Switch(
      activeColor: Theme.of(context).primaryColor,
      value: item.value,
      onChanged: item.isInput ? onChanged : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ItemModel item = widget.item;
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

import 'package:flutter_masked_text/flutter_masked_text.dart';

MoneyMaskedTextController createMoneyController(initialValue,
    {defaultValue = '0.00'}) {
  MoneyMaskedTextController _moneyController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ' ',
  );
  _moneyController.text =
      initialValue != null ? (initialValue * 10).toString() : defaultValue;

  return _moneyController;
}

String formatCost(double cost) {
  if (cost == null) {
    return null;
  }

  MoneyMaskedTextController _controller =
      createMoneyController(cost, defaultValue: null);
  return _controller.text;
}

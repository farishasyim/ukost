import 'package:intl/intl.dart';

extension NumberExtension on num {
  String toCurrency() {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(this);
  }

  String toRawCurrency() {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    ).format(this);
  }
}

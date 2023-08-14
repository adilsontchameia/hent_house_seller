import 'package:intl/intl.dart';

class KwanzaFormatter {
  static String formatKwanza(double value) {
    var locale = 'pt_AO';

    var formatter =
        NumberFormat.currency(locale: locale, name: 'Kz', symbol: 'Kz');

    return formatter.format(value);
  }
}

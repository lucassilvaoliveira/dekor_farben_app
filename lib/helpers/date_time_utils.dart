import 'package:intl/intl.dart';

convertDateTimeToShowOnScreen(DateTime date, String format) =>
    DateFormat(format).format(date);



import 'package:intl/intl.dart';

String convertDate(String dateString) {
  // Define the input format of the string date
  DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  // Parse the string to a DateTime object
  DateTime dateTime = inputFormat.parse(dateString);

  // Define the output format
  DateFormat outputFormat = DateFormat("HH:mm dd/MM");
  // Format the DateTime object to the desired format
  String formattedDate = outputFormat.format(dateTime);

  return formattedDate;
}
String convertDate(String date, bool? all) {
  Map<String, String> monthNames = {
    'Jan': '1',
    'Feb': '2',
    'Mar': '3',
    'Apr': '4',
    'May': '5',
    'Jun': '6',
    'Jul': '7',
    'Aug': '8',
    'Sep': '9',
    'Oct': '10',
    'Nov': '11',
    'Dec': '12',
  };

  if (date == "_") {
    return "____/__/__";
  }
  List<String> parts = date.split(' ');

  String month = parts[2];
  String year = parts[3];
  String time = parts[4];

  String? arabicMonth = monthNames[month];
  if (all ?? false) {
    return '${parts[1]}/$arabicMonth/$year,$time';
  }

  return '${parts[1]}/$arabicMonth/$year';
}

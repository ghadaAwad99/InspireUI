import 'lookupmessages.dart';

/// Farsi Messages
class FaMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'پیش';
  @override
  String suffixFromNow() => 'بعد';
  @override
  String lessThanOneMinute(int seconds) => 'چند لحظه';
  @override
  String aboutAMinute(int minutes) => 'یک دقیقه';
  @override
  // ignore: unnecessary_brace_in_string_interps
  String minutes(int minutes) => '${minutes} دقیقه';
  @override
  String aboutAnHour(int minutes) => '~یک ساعت';
  @override
  // ignore: unnecessary_brace_in_string_interps
  String hours(int hours) => '${hours} ساعت';
  @override
  String aDay(int hours) => '~یک روز';
  @override
  // ignore: unnecessary_brace_in_string_interps
  String days(int days) => '${days} روز';
  @override
  String aboutAMonth(int days) => '~یک ماه';
  @override
  // ignore: unnecessary_brace_in_string_interps
  String months(int months) => '${months} ماه';
  @override
  String aboutAYear(int year) => '~یک سال';
  @override
  // ignore: unnecessary_brace_in_string_interps
  String years(int years) => '${years} سال';
  @override
  String wordSeparator() => ' ';
}

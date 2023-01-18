import 'lookupmessages.dart';

/// Hungarian Messages
class HuMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'ezelőtt';
  @override
  String suffixFromNow() => 'mostantól';
  @override
  String lessThanOneMinute(int seconds) => 'egy pillanattal';
  @override
  String aboutAMinute(int minutes) => 'egy perccel';
  @override
  String minutes(int minutes) => '$minutes perccel';
  @override
  String aboutAnHour(int minutes) => 'kb. egy órával';
  @override
  String hours(int hours) => '$hours órával';
  @override
  String aDay(int hours) => 'egy nappal';
  @override
  String days(int days) => '$days nappal';
  @override
  String aboutAMonth(int days) => 'kb. egy hónappal';
  @override
  String months(int months) => '$months hónappal';
  @override
  String aboutAYear(int year) => 'kb. egy évvel';
  @override
  String years(int years) => '$years évvel';
  @override
  String wordSeparator() => ' ';
}

/// Hungarian short Messages
class HuShortMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'most';
  @override
  String aboutAMinute(int minutes) => '1 perce';
  @override
  String minutes(int minutes) => '$minutes perce';
  @override
  String aboutAnHour(int minutes) => '~1 órája';
  @override
  String hours(int hours) => '$hours órája';
  @override
  String aDay(int hours) => '~1 napja';
  @override
  String days(int days) => '$days napja';
  @override
  String aboutAMonth(int days) => '~1 hónapja';
  @override
  String months(int months) => '$months hónapja';
  @override
  String aboutAYear(int year) => '~1 éve';
  @override
  String years(int years) => '$years éve';
  @override
  String wordSeparator() => ' ';
}

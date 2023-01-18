import 'messages/ar_messages.dart';
import 'messages/az_messages.dart';
import 'messages/ca_messages.dart';
import 'messages/cs_messages.dart';
import 'messages/da_messages.dart';
import 'messages/de_messages.dart';
import 'messages/dv_messages.dart';
import 'messages/en_messages.dart';
import 'messages/es_messages.dart';
import 'messages/fa_messages.dart';
import 'messages/fr_messages.dart';
import 'messages/gr_messages.dart';
import 'messages/he_messages.dart';
import 'messages/hi_messages.dart';
import 'messages/hu_messages.dart';
import 'messages/id_messages.dart';
import 'messages/it_messages.dart';
import 'messages/ja_messages.dart';
import 'messages/km_messages.dart';
import 'messages/ko_messages.dart';
import 'messages/ku_messages.dart';
import 'messages/lookupmessages.dart';
import 'messages/nl_messages.dart';
import 'messages/pl_messages.dart';
import 'messages/ro_messages.dart';
import 'messages/ru_messages.dart';
import 'messages/sv_messages.dart';
import 'messages/ta_messages.dart';
import 'messages/th_messages.dart';
import 'messages/tr_messages.dart';
import 'messages/vi_messages.dart';
import 'messages/zh_messages.dart';

String _default = 'en';

Map<String, LookupMessages> _lookupMessagesMap = {
  'en': EnMessages(),
  'es': EsMessages(),
  'en_short': EnShortMessages(),
  'es_short': EsShortMessages(),
  'ar': ArMessages(),
  'az': AzMessages(),
  'ca': CaMessages(),
  'cs': CsMessages(),
  'da': DaMessages(),
  'de': DeMessages(),
  'dv': DvMessages(),
  'fa': FaMessages(),
  'fr': FrMessages(),
  'gr': GrMessages(),
  'he': HeMessages(),
  'hi': HiMessages(),
  'id': IdMessages(),
  'it': ItMessages(),
  'ja': JaMessages(),
  'km': KmMessages(),
  'ko': KoMessages(),
  'ku': KuMessages(),
  'pl': PlMessages(),
  'nl': NlMessages(),
  'ro': RoMessages(),
  'ru': RuMessages(),
  'sv': SvMessages(),
  'ta': TaMessages(),
  'th': ThMessages(),
  'tr': TrMessages(),
  'vi': ViMessages(),
  'zh': ZhMessages(),
  'hu': HuMessages(),
};

class TimeAgo {
  static String format(DateTime date,
      {String? locale, DateTime? clock, bool? allowFromNow}) {
    final localeVal = locale ?? _default;
    final allowNow = allowFromNow ?? false;
    final messages = _lookupMessagesMap[localeVal] ?? EnMessages();
    final clockTime = clock ?? DateTime.now();
    var elapsed =
        clockTime.millisecondsSinceEpoch - date.millisecondsSinceEpoch;

    String prefix, suffix;

    if (allowNow && elapsed < 0) {
      elapsed = date.isBefore(clockTime) ? elapsed : elapsed.abs();
      prefix = messages.prefixFromNow();
      suffix = messages.suffixFromNow();
    } else {
      prefix = messages.prefixAgo();
      suffix = messages.suffixAgo();
    }

    final num seconds = elapsed / 1000;
    final num minutes = seconds / 60;
    final num hours = minutes / 60;
    final num days = hours / 24;
    final num months = days / 30;
    final num years = days / 365;

    String result;
    if (seconds < 45) {
      result = messages.lessThanOneMinute(seconds.round());
    } else if (seconds < 90) {
      result = messages.aboutAMinute(minutes.round());
    } else if (minutes < 45) {
      result = messages.minutes(minutes.round());
    } else if (minutes < 90) {
      result = messages.aboutAnHour(minutes.round());
    } else if (hours < 24) {
      result = messages.hours(hours.round());
    } else if (hours < 48) {
      result = messages.aDay(hours.round());
    } else if (days < 30) {
      result = messages.days(days.round());
    } else if (days < 60) {
      result = messages.aboutAMonth(days.round());
    } else if (days < 365) {
      result = messages.months(months.round());
    } else if (years < 2) {
      result = messages.aboutAYear(months.round());
    } else {
      result = messages.years(years.round());
    }

    return [prefix, result, suffix]
        .where((str) => str.isNotEmpty)
        .join(messages.wordSeparator());
  }
}

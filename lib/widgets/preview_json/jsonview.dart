part of '../preview_json.dart';

const fontSize = 12.0;

class JsonView extends StatefulWidget {
  final Map<dynamic, dynamic> jsonObj;
  final bool? notRoot;

  const JsonView(this.jsonObj, {Key? key, this.notRoot}) : super(key: key);

  @override
  JsonViewState createState() => JsonViewState();
}

class JsonViewState extends State<JsonView> {
  @override
  Widget build(BuildContext context) {
    if (widget.notRoot ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _getList())),
          const Text('},',
              style: TextStyle(color: Colors.grey, fontSize: fontSize))
        ],
      );
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: _getList());
  }

  List<Widget> _getList() {
    final list = <Widget>[];
    for (final entry in widget.jsonObj.entries) {
      final ink = isInkWell(entry.value);
      list
        ..add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(entry.key,
                style:
                    const TextStyle(color: Colors.purple, fontSize: fontSize)),
            const Text(
              ':',
              style: TextStyle(color: Colors.grey, fontSize: fontSize),
            ),
            const SizedBox(width: 10),
            getValueWidget(entry)
          ],
        ))
        ..add(const SizedBox(height: 4));

      if (ink) {
        list.add(getContentWidget(entry.value));
      }
    }
    return list;
  }

  static StatefulWidget getContentWidget(dynamic content) {
    if (content is List) {
      return JsonArrayViewerWidget(content, notRoot: true);
    } else {
      return JsonView(content, notRoot: true);
    }
  }

  static bool isInkWell(dynamic content) {
    if (content == null) {
      return false;
    } else if (content is int) {
      return false;
    } else if (content is String) {
      return false;
    } else if (content is bool) {
      return false;
    } else if (content is double) {
      return false;
    } else if (content is List) {
      if (content.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
    return true;
  }

  Widget getValueWidget(MapEntry entry) {
    if (entry.value == null) {
      return const Expanded(
          child: Text(
        'undefined',
        style: TextStyle(color: Colors.grey, fontSize: fontSize),
      ));
    } else if (entry.value is int) {
      return Expanded(
          child: Text(
        entry.value.toString(),
        style: const TextStyle(color: Colors.teal, fontSize: fontSize),
      ));
    } else if (entry.value is String) {
      return Expanded(
          child: Text(
        '"${entry.value}""',
        style: const TextStyle(color: Colors.redAccent, fontSize: fontSize),
      ));
    } else if (entry.value is bool) {
      return Expanded(
          child: Text(
        entry.value.toString(),
        style: const TextStyle(color: Colors.purple, fontSize: fontSize),
      ));
    } else if (entry.value is double) {
      return Expanded(
          child: Text(
        entry.value.toString(),
        style: const TextStyle(color: Colors.teal, fontSize: fontSize),
      ));
    } else if (entry.value is List) {
      return const Text(
        '[',
        style: TextStyle(color: Colors.grey, fontSize: fontSize),
      );
    }
    return const Text(
      '{',
      style: TextStyle(color: Colors.grey, fontSize: fontSize),
    );
  }

//  static isExtensible(dynamic content){
//    if(content == null){
//      return false;
//    }else if(content is int){
//      return false;
//    }else if (content is String) {
//      return false;
//    } else if (content is bool) {
//      return false;
//    } else if (content is double) {
//      return false;
//    }
//    return true;
//  }

//  static getTypeName(dynamic content){
//    if (content is int){
//      return 'int';
//    }else if (content is String) {
//      return 'String';
//    } else if (content is bool) {
//      return 'bool';
//    } else if (content is double) {
//      return 'double';
//    } else if(content is List){
//      return 'List';
//    }
//    return 'Object';
//  }

}

class JsonArrayViewerWidget extends StatefulWidget {
  final List<dynamic> jsonArray;

  final bool? notRoot;

  const JsonArrayViewerWidget(this.jsonArray, {Key? key, this.notRoot})
      : super(key: key);

  @override
  JsonArrayViewerWidgetState createState() => JsonArrayViewerWidgetState();
}

class JsonArrayViewerWidgetState extends State<JsonArrayViewerWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.notRoot ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _getList())),
          const Text('],',
              style: TextStyle(color: Colors.grey, fontSize: fontSize))
        ],
      );
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: _getList());
  }

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _getList() {
    final list = <Widget>[];
    var i = 0;
    for (final dynamic content in widget.jsonArray) {
      final ink = JsonViewState.isInkWell(content);
      list
        ..add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[getValueWidget(content, i)],
        ))
        ..add(const SizedBox(height: 4));
      if (ink) {
        list.add(JsonViewState.getContentWidget(content));
      }
      i++;
    }
    return list;
  }

  Widget getValueWidget(dynamic content, int index) {
    if (content == null) {
      return const Expanded(
          child: Text(
        'undefined',
        style: TextStyle(color: Colors.grey, fontSize: fontSize),
      ));
    } else if (content is int) {
      return Expanded(
          child: Text(
        content.toString(),
        style: const TextStyle(color: Colors.teal, fontSize: fontSize),
      ));
    } else if (content is String) {
      return Expanded(
          child: Text(
        '"$content"',
        style: const TextStyle(color: Colors.redAccent, fontSize: fontSize),
      ));
    } else if (content is bool) {
      return Expanded(
          child: Text(
        content.toString(),
        style: const TextStyle(color: Colors.purple, fontSize: fontSize),
      ));
    } else if (content is double) {
      return Expanded(
          child: Text(
        content.toString(),
        style: const TextStyle(color: Colors.teal, fontSize: fontSize),
      ));
    } else if (content is List) {
      return const Text(
        '[',
        style: TextStyle(color: Colors.grey, fontSize: fontSize),
      );
    }
    return const Text(
      '{',
      style: TextStyle(color: Colors.grey, fontSize: fontSize),
    );
  }
}

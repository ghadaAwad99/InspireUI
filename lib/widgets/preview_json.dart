import 'package:flutter/material.dart';

import 'material_tip.dart';
part 'preview_json/jsonview.dart';

class PreviewJson extends StatelessWidget {
  final Map? data;
  final Function? onClickCopy;

  const PreviewJson({
    Key? key,
    this.data,
    this.onClickCopy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.02),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  JsonView(
                    Map<String, dynamic>.from(data!),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: MaterialTip(
              message: 'Copy to Clipboard',
              child: SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 4)),
                  onPressed: onClickCopy as void Function()?,
                  child: Icon(
                    Icons.content_copy,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PlatformError extends StatelessWidget {
  final bool enablePop;
  const PlatformError({this.enablePop = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = const TextTheme(
      bodyText2: TextStyle(fontSize: 16),
    );
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(
                    child: Icon(Icons.cast_connected, size: 100),
                  ),
                  const SizedBox(height: 60),
                  Text(
                    'This feature can not be displayed due to the limit of the framework.',
                    style: theme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Don\'t worry, it still works smoothly\non SmartPhone and Ipad version.',
                    style: theme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          if (enablePop && Navigator.of(context).canPop())
            Container(
              margin: const EdgeInsets.all(10),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
        ],
      ),
    );
  }
}

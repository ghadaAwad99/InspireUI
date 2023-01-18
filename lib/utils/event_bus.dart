import 'package:event_bus/event_bus.dart';

final EventBus eventBus = EventBus();

class EventDrawerSettings {
  const EventDrawerSettings();
}

class EventNavigatorTabbar {
  int index;
  bool isMenu;

  EventNavigatorTabbar(this.index, {this.isMenu = false});
}

class EventDetailSettings {
  const EventDetailSettings();
}

class EventBlogDetailSettings {
  const EventBlogDetailSettings();
}

class EventAppInfo {
  const EventAppInfo();
}

class EventTemplateScreen {
  const EventTemplateScreen();
}

class EventFeatureScreen {
  const EventFeatureScreen();
}

class EventBuildScreen {
  const EventBuildScreen();
}

class EventOpenToggle {
  const EventOpenToggle();
}

class EventUpdateConfig {
  int previewIndex;
  Map<String, dynamic> config;

  EventUpdateConfig(this.previewIndex, this.config);
}

class EventPreviewWidget {
  final int previewIndex;
  final bool isPreviewing;

  const EventPreviewWidget(this.previewIndex, this.isPreviewing);
}

class EventClearPreviewWidget {
  const EventClearPreviewWidget();
}

class EventReloadConfigs {
  String? key;
  Map<String, dynamic> configs;

  EventReloadConfigs(this.configs, {this.key});
}

class EventNavigatorToDesign {
  const EventNavigatorToDesign();
}

class EventNavigatorToBuild {
  const EventNavigatorToBuild();
}

class EventNavigatorToFeature {
  const EventNavigatorToFeature();
}

class EventNavigatorToLicense {
  const EventNavigatorToLicense();
}

class EventEditHomeConfig {
  int index;

  EventEditHomeConfig(this.index);
}

/// Take the screenshot on home screen
class EventHomeScreenShoot {
  EventHomeScreenShoot();
}

class EventHomeScreenShootAtIndex {
  int index;
  bool takeScreenshot = true;

  EventHomeScreenShootAtIndex(this.index, {this.takeScreenshot = true});
}

import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

//是否打开drawer的event
class EventOpenDrawer {
  bool flag;

  EventOpenDrawer(this.flag);
}